Feature: Getting help

  In order to quickly learn how to use the command line interface
  As a AWS Session Credentials user
  I want a command line interface with built-in help

  Scenario: Show help
    When I run `aws-session help` interactively
    Then the output should contain:
    """
    Commands:
    """
