# ruby-net-ldap-gss-spnego

Adapter for GSS-SPNEGO authentication in net-ldap gem 

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'net-ldap-gss-spnego'
```

And then execute:

```sh
$ bundle
```

Or install it yourself as:

```sh
$ gem install net-ldap-gss-spnego
```

## Usage

```ruby
require 'net/ldap/auth_adapter/gss_spnego'

ldap = Net::LDAP.new(
  auth: {
    method: :gss_spnego,
    username: 'administrator',
    password: 'Pa$$w0rd'
  }
)
```
