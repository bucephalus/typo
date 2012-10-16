Feature: Merge Articles
  As a blog administrator
  In order to consolidate articles with similar topics and/or content
  I want to be able to merge two articles into one


  Background:
    Given the blog is set up
    And the following articles exist:
      | title        | body   | id |
      | article 1    | text 1 |  1 |
      | article 2    | text 2 |  2 |
    And the following comments exist:
      | author    | body       | article_id   |
      | author 1  | comment 1a |            1 |
      | author 2  | comment 1b |            1 |
      | author 3  | comment 2a |            2 |
      | author 4  | comment 2b |            2 |
      | author 5  | comment 2c |            2 |
    And I am logged into the admin panel

  Scenario: A non-admin cannot merge two articles.
    Given I log out
    And I am on the edit page for "article 1"
    Then I should not see merge options

  Scenario: Can not merge an article with itself
    And I merge "article 1" with "article 3"
    Then I should be on the admin content page
    And I should see "article 1"
    And I should see "article 2"
    And I should see "merge unsuccessful"

  Scenario: Can not merge with a non-existent article
    And I merge "article 1" with "article 1"
    Then I should be on the admin content page
    And I should see "article 1"
    And I should see "article 2"
    And I should see "merge unsuccessful"

  Scenario: Follow steps to successfully merge article
    Given I am on the edit page for "article 1"
    And I fill in the merge field with the ID of "article 2"
    And I press "Merge"
    Then I should be on the admin content page
    When I go to the home page
    Then I should see "article 1"
    But I should not see "article 2"

  Scenario: When articles are merged, the merged article should contain the text of both previous articles
    Given I merge "article 1" with "article 2"
    Then the text of "article 1" should contain "text 1"
    And the text of "article 1" should contain "text 2"

  Scenario: Successfully merge articles
    Given I merge "article 1" with "article 2"
    Then the text of "article 1" should contain "text 1"
    And the text of "article 1" should contain "text 2"
    And the author of "article 1" should be "author 1"
    And the comments of "article 1" should contain "comment 1a"
    And the comments of "article 1" should contain "comment 1b"
    And the comments of "article 1" should contain "comment 2a"
    And the comments of "article 1" should contain "comment 2b"
    And the comments of "article 1" should contain "comment 2c"




