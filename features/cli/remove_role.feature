Feature: Removing AWS roles

  In order to manage AWS roles
  As an AWS user
  I want to remove stored AWS roles

  Scenario: The specified role is stored
    When I run `aws-session remove role example` interactively
    Then the exit status should be 0

  Scenario: The specified role is not stored
    When I run `aws-session remove role example` interactively
    Then the exit status should be 1
    And the stdout should contain "Unknown role name `example`"
