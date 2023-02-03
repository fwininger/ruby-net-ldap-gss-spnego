# frozen_string_literal: true

require 'net/ldap/auth_adapter'
require 'net/ldap/auth_adapter/sasl'
require 'rubyntlm'

module Net
  class LDAP
    class AuthAdapter
      # This authentication method is accessed by calling #bind with a :method
      # parameter of :gss_spnego. It requires :username, :password and :basename
      # attributes, just like the :simple authentication method. It performs a
      # GSS-SPNEGO authentication with the server, which is presumed to be a
      # Microsoft Active Directory.
      #++
      class GssSpnego < Net::LDAP::AuthAdapter
        def bind(auth)
          user = auth[:username] || auth[:dn]
          password = auth[:password]
          domain = auth[:domain]

          unless user && password
            raise Net::LDAP::BindingInformationInvalidError, 'Invalid binding information'
          end

          challenge_response = proc do |challenge|
            challenge.force_encoding(Encoding::BINARY)
            t2_msg = NTLM::Message.parse(challenge)
            auth_params = { user: user, password: password }
            auth_params[:domain] = domain unless domain.to_s.empty?
            t3_msg = t2_msg.response(auth_params, ntlmv2: true)
            t3_msg.user.force_encoding(Encoding::BINARY)
            t3_msg.serialize
          end

          Net::LDAP::AuthAdapter::Sasl.new(@connection).bind(
            method: :sasl,
            mechanism: 'GSS-SPNEGO',
            initial_credential: NTLM::Message::Type1.new.serialize,
            challenge_response: challenge_response
          )
        end
      end
    end
  end
end

Net::LDAP::AuthAdapter.register(:gss_spnego, Net::LDAP::AuthAdapter::GssSpnego)
