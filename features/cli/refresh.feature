Feature: Refresh currently assumed credential or role

  In order to continue using an assumed role
  As an AWS user
  I want to generate a new session token for the currently assumed role

  Scenario: MFA token code not required
    When I run `aws-session refresh` interactively
    Then the exit status should be 0
    And the file "~/.aws/credentials" should contain "aws_access_key_id"
    And the file "~/.aws/credentials" should contain "aws_secret_access_key"
    And the file "~/.aws/credentials" should contain "aws_session_token"

  Scenario: MFA token code required
    When I run `aws-session refresh` interactively
    And I type "123456"
    Then the exit status should be 0
    And the stdout should contain "MFA token code"
    And the file "~/.aws/credentials" should contain "aws_access_key_id"
    And the file "~/.aws/credentials" should contain "aws_secret_access_key"
    And the file "~/.aws/credentials" should contain "aws_session_token"

  Scenario: No previously assumed role
    When I run `aws-session refresh` interactively
    Then the exit status should be 1
    And the stdout should contain "No currently assumed role"
