Feature: Todo app
  Scenario: Homepage
    Given I am on "the homepage"
    Then I should see "TaskApp"
    And I should not see "tasks completed"
    And I should not see "Delete all completed tasks"

  Scenario: Add Task
    Given I am on "the homepage"
    And I fill in "Example Task" for "todo"
    When I press "Add Task"
    Then I should see "Example Task"
    And I should see "0 of 1 tasks completed"

  Scenario: Complete Task
    Given I am on "the homepage"
    When I press "Done"
    Then I should see "Delete all completed tasks"
    And I should see "1 of 1 tasks completed"

  Scenario: Add another Task
    Given I am on "the homepage"
    And I fill in "Example 2" for "todo"
    When I press "Add Task"
    Then I should see "Example 2"
    Then I should see "Example Task"
    And I should see "1 of 2 tasks completed"

  Scenario: Delete Completed Tasks
    Given I am on "the homepage"
    When I press "Delete all completed tasks"
    Then I should not see "Delete all completed tasks"
    And I should see "0 of 1 tasks completed"
