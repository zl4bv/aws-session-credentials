Feature: Storing MFA device information

  In order to manage MFA devices
  As an AWS IAM user
  I want to store a MFA device information

  Scenario: Adding a generic MFA device
    When I run `aws-session add mfa-device` interactively
    And I type "arn:aws:iam::123456789012:mfa/ExampleMFADevice"
    And I type "generic"
    And I type "default"
    Then the exit status should be 0
    And the stdout should contain "Serial number"
    And the stdout should contain "Device type"
    And the stdout should contain "MFA device alias"

  Scenario: Adding a YubiKey
    When I run `aws-session add mfa-device` interactively
    And I type "arn:aws:iam::123456789012:mfa/ExampleMFADevice"
    And I type "yubikey"
    And I type "credential name"
    And I type "default"
    Then the exit status should be 0
    And the stdout should contain "Serial number"
    And the stdout should contain "Device type"
    And the stdout should contain "OATH credential name"
    And the stdout should contain "MFA device alias"
