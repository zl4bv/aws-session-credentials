Feature: Using a stored credential

  In order to use a set of stored credentials
  As an AWS IAM user
  I want the credentials to be copied to ~/.aws/credentials

  Scenario: Credential is known and does not require MFA token code
    Given a file named ".aws-session" with:
    """
    ---
    credentials:
      example:
    """
    When I run `aws-session assume credential example` interactively
    Then the exit status should be 0
    And the file "~/.aws/credentials" should contain "aws_access_key_id"
    And the file "~/.aws/credentials" should contain "aws_secret_access_key"

  Scenario: Credential is known and requires MFA token code
    Given a file named ".aws-session" with:
    """
    ---
    credentials:
      example:
        mfa_name: mfadevicename
    """
    When I run `aws-session assume credential example` interactively
    And I type "123456"
    Then the exit status should be 0
    And the stdout should contain "MFA token code"
    And the file "~/.aws/credentials" should contain "aws_access_key_id"
    And the file "~/.aws/credentials" should contain "aws_secret_access_key"
    And the file "~/.aws/credentials" should contain "aws_session_token"

  Scenario: Credential is unknown
    Given a file named ".aws-session" with:
    """
    ---
    credentials:
    """
    When I run `aws-session assume credential example` interactively
    Then the exit status should be 1
    And the stderr should contain "Unknown credential `example`"
