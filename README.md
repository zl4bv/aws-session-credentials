# Aws::Session::Credentials

[![Build Status](https://travis-ci.org/zl4bv/aws-session-credentials.svg)](https://travis-ci.org/zl4bv/aws-session-credentials)

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
  [--access-key-id=ACCESS-KEY-ID]          # Access key used to generate session token
  [--secret-access-key=SECRET-ACCESS-KEY]  # Secret key used to generate session token
  [--region=REGION]                        # AWS region to connect to
  [--config-file=CONFIG-FILE]              # YAML file to load config from
                                           # Default: ~/.aws/credentials.yml
  [--credential-file=CREDENTIAL-FILE]      # INI file to save session credentials to
                                           # Default: ~/.aws/credentials
  [--profile=PROFILE]                      # Profile that session token will be loaded into
                                           # Default: default
  [--duration=N]                           # Duration, in seconds, that credentials should remain valid
                                           # Default: 1
  [--mfa-device=MFA-DEVICE]                # ARN of MFA device
  [--mfa-code=MFA-CODE]                    # Six digit code from MFA device
```

### Config File

By default this is located at `~/.aws/credentials.yml`.

Example:

```yaml
---
aws_access_key_id: AKIAIOSFODNN7EXAMPLE
aws_secret_access_key: wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY
region: ap-southeast-2
duration: 86400
mfa_device: arn:aws:iam::000000000000:mfa/user.name@example.com
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/zl4bv/aws-session-credentials. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.
