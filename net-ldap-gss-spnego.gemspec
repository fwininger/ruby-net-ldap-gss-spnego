# frozen_string_literal: true
require 'date'

Gem::Specification.new do |s|
  s.name = 'net-ldap-gss-spnego'
  s.version = '0.1.0'
  s.date = Date.today.to_s
  s.author = ['Florian Wininger']
  s.homepage = 'https://github.com/fwininger/ruby-net-ldap-gss-spnego'
  s.summary = 'Adapter for GSS-SPNEGO authentication in net-ldap gem'
  s.description = 'Add the GSS-SPNEGO authentication mechanism in net-ldap gem'
  s.license = 'MIT'
  s.files = Dir.glob('{bin,lib}/**/*') + %w[LICENSE README.md]
  s.require_paths = ['lib']

  s.required_ruby_version = '>= 2.4.0'

  s.add_runtime_dependency 'net-ldap', '~> 0.16'
  s.add_runtime_dependency 'rubyntlm', '~> 0.6'
  s.add_development_dependency 'rubocop', '~> 0.79.0'
end
