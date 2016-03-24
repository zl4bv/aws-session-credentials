Feature: Removing AWS credentials

  In order to manage AWS credentials
  As an AWS user
  I want to remove stored AWS credentials

  Scenario: The specified credential is stored
    When I run `aws-session remove credential example` interactively
    Then the exit status should be 0

  Scenario: The specified credential is not stored
    When I run `aws-session remove credential example` interactively
    Then the exit status should be 1
    And the stderr should contain "Unknown credential `example`"
