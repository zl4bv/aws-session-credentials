Feature: Using a stored role

  In order to use a role
  As an AWS IAM user
  I want temporary security credentials to be generated for the role
  And the credentials to be copied to ~/.aws/credentials

  Given a user has already assumed a role
  When the user wants to assume a new role
  Then the user must assume a credential
  And then assume the new role
  This workflow could be improved by assuming the user wants to use their last
  assumed credentials to assume the new role. Alternatively, we could introduce
  the concept of "presets" which pairs a credential with a role and then the
  user could assume the preset instead. The preset could check if an
  unexpired session token already exists for the credential and automatically
  use it or issue a new token if not.

  Scenario: Specified role is known
    Given a file named ".aws-session" with:
    """
    ---
    roles:
      example:
    """
    When I run `aws-session assume credential example` interactively
    Then the exit status should be 0
    And the file "~/.aws/credentials" should contain "aws_access_key_id"
    And the file "~/.aws/credentials" should contain "aws_secret_access_key"
    And the file "~/.aws/credentials" should contain "aws_session_token"

  Scenario: Specified role is unknown
    Given a file named ".aws-session" with:
    """
    ---
    roles:
    """
    When I run `aws-session assume credential example` interactively
    Then the exit status should be 1
    And the stdout should contain "Unknown credential `example`"
