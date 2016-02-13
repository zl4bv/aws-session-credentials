Feature: Listing AWS IAM roles

  In order to manage AWS IAM roles
  As an AWS user
  I want to list stored AWS IAM roles

  Scenario: There are stored AWS IAM roles
    When I run `aws-session list roles` interactively
    Then the exit status should be 0
    And the stdout should contain "Roles:"

  Scenario: There are no stored AWS IAM roles
    When I run `aws-session list roles` interactively
    Then the exit status should be 1
    And the stdout should contain "There are no stored Roles"
