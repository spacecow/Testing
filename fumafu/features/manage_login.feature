

  Scenario Outline: Login Options and Actions
    Given the following teacher record
    Given the following student record
    Given I go to the <page>
    When I fill in 'login.user_name' with "<login>"
    And I fill in 'login.password' with "<password>"
    And I press 'login.button'
    Then I should see <action>

    Examples: 
      | page            | login          | password | action                                 |
      | login page      | johan_sveholm  | wrong    | 'login.flash.invalid_user_or_password' |
      | login page      | kurosawa_akira | secret   | "黒澤 明"                           |
      | list of courses | johan_sveholm  | secret   | 'courses.listing'                      |
      | login page      | johan_sveholm  | secret   | todays day                             |

  Scenario: Redirection
    Given the following teacher record
    Given I am logged in as "johan_sveholm" with password "secret"
    When I am on the list of template klasses
    And I select "Monday" from "template_day"

