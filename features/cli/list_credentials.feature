Feature: Listing AWS credentials

  In order to manage AWS credentials
  As an AWS user
  I want to list stored AWS credentials

  Scenario: There are stored AWS credentials
    When I run `aws-session list credentials` interactively
    Then the exit status should be 0
    And the stdout should contain "Credentials:"

  Scenario: There are no stored AWS credentials
    When I run `aws-session list credentials` interactively
    Then the exit status should be 1
    And the stderr should contain "There are no stored credentials"
