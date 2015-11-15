# Aws::Session::Credentials

[![Build Status](https://travis-ci.org/zl4bv/aws-session-credentials.svg)](https://travis-ci.org/zl4bv/aws-session-credentials)
[![Gem Version](https://badge.fury.io/rb/aws-session-credentials.svg)](https://badge.fury.io/rb/aws-session-credentials)

Command-line tool to generate AWS session credentials.

Gets a set of session credentials from the AWS STS service and saves them to
`~/.aws/credentials` (by default). You can optionally provide an MFA device and
code too if your IAM user/role requires it.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'aws-session-credentials'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install aws-session-credentials

## Usage

### Generating new session credentials

Example:

```
$ aws-session --mfa-code 123456
```

To set the full list of CLI options:

```
$ aws-session --help new

Usage:
  aws-session

Options:
Usage:
  aws-session new

Options:
  [--aws-access-key-id=AWS-ACCESS-KEY-ID]          # Access key used to generate session token
  [--aws-secret-access-key=AWS-SECRET-ACCESS-KEY]  # Secret key used to generate session token
  [--aws-region=AWS-REGION]                        # AWS region to connect to
  [--config-file=CONFIG-FILE]                      # YAML file to load config from
                                                   # Default: ~/.aws/aws-session-config.yml
  [--source-profile=SOURCE-PROFILE]                # Profile in config file that user credentials will be loaded from
                                                   # Default: default
  [--profile=PROFILE]                              # Profile that session token will be loaded into
                                                   # Default: default
  [--duration=N]                                   # Duration, in seconds, that credentials should remain valid
  [--mfa-device=MFA-DEVICE]                        # ARN of MFA device
  [--mfa-code=MFA-CODE]                            # Six digit code from MFA device
  [--yubikey-name=YUBIKEY-NAME]                    # Name of yubikey device
                                                   # Default: Yubikey
  [--oath-credential=OATH-CREDENTIAL]              # Name of OATH credential
```

### Assuming a role

Example:

```
$ aws-session assume-role --role-arn=ROLE_ARN --role-session-name=ROLE_SESSION_NAME
```

### Source profiles

Instead of specifying all of the options via the command line each time you
want to generate new session credentials, you can store the options in a
*source profile*.

```
$ aws-session configure
Source profile (leave blank for "default"):
AWS Access Key ID: AKIAIOSFODNN7EXAMPLE
AWS Secret Access Key:
AWS region: ap-southeast-2
Session duration (in seconds): 86400

Configure MFA? y
MFA device ARN: arn:aws:iam::000000000000:mfa/user.name@example.com

Configure Yubikey? y
OATH credential name: user.name@example.com@accountalias
```

See `aws-session --help configure` for more info. By default, the configuration
is stored in `~/.aws/aws-session-config.yml`.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/zl4bv/aws-session-credentials. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.
