Feature: view pages
  Scenario: Homepage
    Given I am on "the homepage"
    Then I should see "TaskApp"

  Scenario: Add Task
    Given I am on "the homepage"
    And I fill in "Example Task" for "todo"
    When I press "Add Task"
    Then I should see "Example Task"
