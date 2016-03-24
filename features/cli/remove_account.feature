Feature: Removing AWS accounts

  In order to manage AWS accounts
  As an AWS user
  I want to remove stored AWS accounts

  Scenario: The specified account is stored
    When I run `aws-session remove account example` interactively
    Then the exit status should be 0

  Scenario: The specified account is not stored
    When I run `aws-session remove account example` interactively
    Then the exit status should be 1
    And the stderr should contain "Unknown account name `example`"
