Feature: Default CLI command

  In order to quickly use and understand AWS Session Credentials
  As a AWS Session Credentials user
  I want the default command to make sensible choices

  Scenario: First time use
    When I run `aws-session` interactively
    Then the output should contain:
    """
    This is the first time you have used AWS Session Credentials.

    Please add a credential by typing:
      aws-session add credential

    If your credential requires MFA then type the following *before* adding
    the credential:
      aws-session add mfa-device

    Then add a role by typing:
      aws-session add role
    """

  Scenario: Subsequent use
    When I run `aws-session` interactively
    Then it should invoke the "refresh" thor action
