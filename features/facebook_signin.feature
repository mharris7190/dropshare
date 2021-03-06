Feature: Signing in to DropShare with Facebook
	In order to log into DropShare
	As a user
	I want to log in with my Facebook account
	
  @omniauth_test_success
  Scenario: A user successfully signs in with facebook (Happy Path)
    Given I am on the home page
    When I follow "Sign in"
    And I go to the home page
    Then I should be on the feed page
    And I should see "Test User is logged in"
      
  @omniauth_test_failure
  Scenario: A user unsuccessfully signs in with facebook (Sad Path)
    Given I am on the home page
    When I follow "Sign in"
    Then I should be on the home page
    