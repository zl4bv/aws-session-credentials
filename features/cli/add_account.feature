Feature: Storing AWS accounts

  In order to manage AWS accounts
  As an AWS user
  I want to store an AWS account
  So I can reference an account by name instead of by ID

  Scenario: Adding an AWS account
    When I run `aws-session add account` interactively
    And I type "000000000000"
    And I type "default"
    Then the exit status should be 0
    And the stdout should contain "AWS Account ID"
    And the stdout should contain "Account alias"
