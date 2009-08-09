@klass


  Scenario Outline: Delete Classes
    Given I have courses titled "入門 I, 入門 II"
    Given the following teacher record
    Given the following student record
    Given the following klass record
    Given the following attendance record
    Given I go to the list of <list>
    And I am logged in as "johan_sveholm" with password "secret"
    And I should see '<list>.listing'
    And I <extra>
    And I <extra2>
    And I should have 2 klasses
    And I should have 2 teachers
    And I should have 1 student
    When I follow 'delete' within "klass_2"
    Then I should see 'klasses.flash.try_to_delete_klass_with_students'
    And I should have 2 klasses
    And I should have 2 teachers
    And I should have 1 student
    When I follow 'delete' within "klass_1"
    And I should have 1 klass
    And I should have 2 teachers
    And I should have 1 student

    Examples: 
      | list    | extra                          | extra2                                         |
      | klasses | should see "入門コース"   | should see "11:00~12:00"                       |
      | courses | should see "入門 I"          | follow 'show' in the row containing "入門 I" |
      | klasses | follow 'show' within "klass_2" | follow "入門 I"                              |

  Scenario: Duplicate a Generated Class
    Given I have courses titled "入門 I, 入門 II"
    Given the following teacher record
    Given the following template klass record
    Given I go to the list of klasses
    And I am logged in as "johan_sveholm" with password "secret"
    And I should have 1 klass
    And I should see "入門コース"
    And I should see "11:00~12:00"
    When I follow "+" within "入門_I_1100_1200"
    Then I should have 2 klasses
    When I follow 'show' within klass 1
    Then I should see 'course'": 入門 I"
    And I should see 'teacher'": Sveholm Johan"
    And I should see 'capacity'": 0"
    And I should see todays date
    And I should see 'klass_time'": 11:00~12:00"
    And I should see 'cancel'": false"
    And I should see 'mail_sending'": 0"
    When I follow 'back'
    And I follow 'show' within klass 2
    Then I should see 'course'": 入門 I"
    And I should not see 'teacher'": Sveholm Johan"
    And I should see 'capacity'": 0"
    And I should see todays date
    And I should see 'klass_time'": 11:00~12:00"
    And I should see 'cancel'": false"
    And I should see 'mail_sending'": 0"

  Scenario: Add a Class after getting Errors
    Given I have courses titled "入門 I, 入門 II"
    Given the following teacher record
    Given I go to the list of klasses
    And I am logged in as "johan_sveholm" with password "secret"
    And I should have 0 klasses
    When I follow 'klasses.new'
    And I should see 'klasses.new'
    And I press 'create'
    And I should have 0 klasses
    Then I should see "Course "'activerecord.errors.messages.blank'
    And I should see "Start time "'activerecord.errors.messages.blank'
    And I should see "End time "'activerecord.errors.messages.blank'
    When I fill in 'start_time' with "13:00"
    And I fill in 'end_time' with "15:00"
    And I press 'create'
    And I should have 0 klasses
    Then I should see "Course "'activerecord.errors.messages.blank'
    And I should not see "Start time "'activerecord.errors.messages.blank'
    And I should not see "End time "'activerecord.errors.messages.blank'
    When I select "入門 I" from 'course'
    And I press 'create'
    Then I should see 'klasses.listing'
    And I should see "入門コース"
    And I should see "13:00~15:00"
    And I should have 1 klass

  Scenario Outline: Edit a Class and show the Result
    Given I have courses titled "入門 I, 入門 II"
    Given the following teacher record
    Given the following klass record
    Given I go to the list of <list>
    And I am logged in as "johan_sveholm" with password "secret"
    And I <extra>
    When I follow <edit>
    And I fill in 'note' with "Something important"
    And I fill in 'title' with "Some title"
    And I press 'update'
    And I follow 'show' within "klass_1"
    Then I should see 'course'": 入門 I"
    And I should see 'teacher'": Sveholm Johan"
    And I should see 'capacity'": 0"
    And I should see todays date
    And I should see 'klass_time'": 13:00~15:00"
    And I should see 'title'": Some title"
    And I should see 'cancel'": false"
    And I should see 'mail_sending'": 0"
    And I should see 'note'": Something important"
    And I should have 1 klasses

    Examples: 
      | list    | extra                                          | edit                    |
      | klasses | should see "入門コース"                   | 'edit' within "klass_1" |
      | courses | follow 'show' in the row containing "入門 I" | 'edit' within "klass_1" |
      | klasses | follow 'show' within "klass_1"                 | 'edit'                  |

  Scenario Outline: Chosen Teachers and Classrooms cannot be chosen again at the same Time
    Given I have courses titled "入門 I, 入門 II"
    Given I have the following classroom records
    Given the following teacher record
    Given the following klass record
    Given the following template klass record
    When I go to the list of <object>es
    And I am logged in as "johan_sveholm" with password "secret"
    Then I should see "Sveholm Johan" within "<object>_1"
    And I should not see "Bumba Ali" within "<object>_1"
    And I should see "Loser K1" within "<object>_1"
    And I should see "room_1" within "<object>_1"
    And I should not see "room_2" within "<object>_1"
    And I should see "room_3" within "<object>_1"
    And I should see "room_4" within "<object>_1"
    And I should not see "Sveholm Johan" within "<object>_2"
    And I should see "Bumba Ali" within "<object>_2"
    And I should see "Loser K1" within "<object>_2"
    And I should not see "room_1" within "<object>_2"
    And I should see "room_2" within "<object>_2"
    And I should see "room_3" within "<object>_2"
    And I should see "room_4" within "<object>_2"

    Examples: 
      | object         |
      | klass          |
      | template_klass |

  @students
  Scenario: 
    Given I have courses titled "入門 I, 入門 II"
    Given the following teacher record
    Given the following student record
    Given the following attendance record
    Given the following klass record
    When I go to the list of klasses
    And I am logged in as "johan_sveholm" with password "secret"
    Then I should see "Kurosawa Akira" within "klass_1"
    And I should see "Koda Kumiko" within "klass_1"
    And I should not see "Adae Mao" within "klass_1"
    And I should see "Kurosawa Akira" within "klass_2"
    And I should see "Koda Kumiko" within "klass_2"
    And I should not see "Adae Mao" within "klass_2"
    And I should not see "Kurosawa Akira" within "klass_3"
    And I should not see "Koda Kumiko" within "klass_3"
    And I should see "Adae Mao" within "klass_3"

