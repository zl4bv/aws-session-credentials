Feature: Listing AWS accounts

  In order to manage AWS accounts
  As an AWS user
  I want to list stored AWS accounts

  Scenario: There are stored AWS accounts
    When I run `aws-session list accounts` interactively
    Then the exit status should be 0
    And the stdout should contain "Accounts:"

  Scenario: There are no stored AWS accounts
    When I run `aws-session list accounts` interactively
    Then the exit status should be 1
    And the stderr should contain "There are no stored accounts"
