Feature: Listing MFA devices

  In order to manage MFA devices
  As an AWS user
  I want to list stored MFA devices

  Scenario: There are stored MFA devices
    When I run `aws-session list mfa-devices` interactively
    Then the exit status should be 0
    And the stdout should contain "MFA devices:"

  Scenario: There are no stored MFA devices
    When I run `aws-session list mfa-devices` interactively
    Then the exit status should be 1
    And the stderr should contain "There are no stored MFA devices"
