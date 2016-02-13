Feature: Storing AWS IAM roles

  In order to manage AWS IAM roles
  As an AWS IAM user
  I want to store an AWS IAM role

  Scenario: Adding an IAM role using an account ID
    When I run `aws-session add role` interactively
    And I type "RoleName"
    And I type "000000000000"
    And I type "RoleAlias"
    Then the exit status should be 0
    And the stdout should contain "Role Name"
    And the stdout should contain "Account Name or ID"
    And the stdout should contain "Role Alias"

  Scenario: Adding an IAM role using a known account name
    Given a file named ".aws-session" with:
    """
    ---
    accounts:
      AccountName:
    """
    When I run `aws-session add role` interactively
    And I type "RoleName"
    And I type "AccountName"
    And I type "RoleAlias"
    Then the exit status should be 0
    And the stdout should contain "Role Name"
    And the stdout should contain "Account Name or ID"
    And the stdout should contain "Role Alias"

  Scenario: Adding an IAM role using an unknown account name
    Given a file named ".aws-session" with:
    """
    ---
    accounts:
    """
    When I run `aws-session add role` interactively
    And I type "RoleName"
    And I type "AccountName"
    Then the exit status should be 1
    And the stdout should contain "Role Name"
    And the stdout should contain "Account Name or ID"
    And the stderr should contain "Unknown MFA device `mfadevicename`"
