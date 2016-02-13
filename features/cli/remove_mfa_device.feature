Feature: Removing MFA devices

  In order to manage MFA devices
  As an AWS user
  I want to remove stored MFA devices

  Scenario: The specified MFA device is stored
    When I run `aws-session remove mfa-device example` interactively
    Then the exit status should be 0

  Scenario: The specified MFA device is not stored
    When I run `aws-session remove mfa-device example` interactively
    Then the exit status should be 1
    And the stdout should contain "Unknown MFA device `example`"
