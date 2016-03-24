Feature: Storing AWS access credentials

  In order to manage AWS access credentials
  As an AWS IAM user
  I want to store an AWS access credential

  Scenario: Adding a long-term access credential without an MFA device
    When I run `aws-session add credential` interactively
    And I type "AKIAXXXXXXXXXXXX"
    And I type "secretaccesskey1234567890"
    And I type ""
    And I type "default"
    Then the exit status should be 0
    And the stdout should contain "AWS Secret Access Key"
    And the stdout should contain "AWS Secret Access Key"
    And the stdout should contain "MFA device (leave blank for none)"
    And the stdout should contain "Credential alias"

  Scenario: Adding a temporary security credential without an MFA device
    When I run `aws-session add credential` interactively
    And I type "ASIAXXXXXXXXXXXX"
    And I type "secretaccesskey1234567890"
    And I type "sessiontoken1234567890"
    And I type ""
    And I type "default"
    Then the exit status should be 0
    And the stdout should contain "AWS Secret Access Key"
    And the stdout should contain "AWS Secret Access Key"
    And the stdout should contain "AWS Session Token"
    And the stdout should contain "MFA device (leave blank for none)"
    And the stdout should contain "Credential alias"

  Scenario: Adding a long-term access credential with a known MFA device
    Given a file named ".aws-session" with:
    """
    ---
    mfa_devices:
      mfadevicename:
    """
    When I run `aws-session add credential` interactively
    And I type "AKIAXXXXXXXXXXXX"
    And I type "secretaccesskey1234567890"
    And I type "mfadevicename"
    And I type "default"
    Then the exit status should be 0
    And the stdout should contain "AWS Secret Access Key"
    And the stdout should contain "AWS Secret Access Key"
    And the stdout should contain "MFA device (leave blank for none)"
    And the stdout should contain "Credential alias"

  Scenario: Adding a long-term access credential with an unknown MFA device
    Given a file named ".aws-session" with:
    """
    ---
    mfa_devices:
    """
    When I run `aws-session add credential` interactively
    And I type "AKIAXXXXXXXXXXXX"
    And I type "secretaccesskey1234567890"
    And I type "mfadevicename"
    Then the exit status should be 1
    And the stdout should contain "AWS Secret Access Key"
    And the stdout should contain "AWS Secret Access Key"
    And the stdout should contain "MFA device (leave blank for none)"
    And the stderr should contain "Unknown MFA device `mfadevicename`"
