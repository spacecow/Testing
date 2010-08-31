Background:
Given a setting exists with name: "main"
And a user exists with username: "johan", role: "god"
And a user: "prince" exists with role: "teacher", username: "prince"
And a klass: "20" exists with date: "2010-08-20"

@confirm
Scenario: Confirm a class
Given a user is logged in as "johan"
And a teaching exists with klass: klass "20", teacher: user "prince", status_mask: 4
When I go to the confirm page for user: "prince" on "2010-08-18"
And I confirmed the klass
And I press "Confirm"
Then I should see "Successfully confirmed class(es)." as notice flash message
And I should be redirected to the already confirmed page for user: "prince"
And a teaching should exist with klass: that klass, teacher: user "prince", status_mask: 33
And 1 teachings should exist

@no_over_write
Scenario: A confirmation should not cancel out previous confirmation
Given a user is logged in as "johan"
And a klass: "10" exists with date: "2010-08-10"
And a teaching exists with klass: klass "10", teacher: user "prince", status_mask: 33
And a teaching exists with klass: klass "20", teacher: user "prince", status_mask: 4
When I go to the confirm page for user: "prince" on "2010-08-18"
And I confirmed the klass
And I press "Confirm"
Then I should see "Successfully confirmed class(es)." as notice flash message
And I should be redirected to the already confirmed page for user: "prince"
And a teaching should exist with klass: klass "10", teacher: user "prince", status_mask: 33
And a teaching should exist with klass: klass "20", teacher: user "prince", status_mask: 33
And 2 teachings should exist

@decline
Scenario: Decline a class
Given a user is logged in as "johan"
And a teaching exists with klass: klass "20", teacher: user "prince", status_mask: 4
When I go to the confirm page for user: "prince" on "2010-08-18"
And I declined the klass
And I press "Confirm"
Then I should see "Successfully confirmed class(es)." as notice flash message
And I should be redirected to the already confirmed page for user: "prince"
And a teaching should exist with klass: that klass, teacher: user "prince", status_mask: 2
And 1 teachings should exist

# #In order to make this test work, you have to comment out
# #not_confirmed in the users_controller!
# @no_confirm_twice
# Scenario: A teacher should not be able to confirm the same class twice
# Given a user is logged in as "johan"
# And a teaching exists with klass: klass "20", teacher: user "prince", status_mask: 33
# When I go to the confirm page for user: "prince" on "2010-08-18"
# And I confirmed the klass
# And I press "Confirm"
# Then a teaching should exist with klass: klass "20", teacher: user "prince", status_mask: 33
# And 1 teachings should exist

# #In order to make this test work, you have to comment out
# #not_declined in the users_controller!
# @no_confirm_already_declined
# Scenario: A teacher should not be able to confirm a declined class
# Given a user is logged in as "johan"
# And a teaching exists with klass: klass "20", teacher: user "prince", status_mask: 2
# When I go to the confirm page for user: "prince" on "2010-08-18"
# And I confirmed the klass
# And I press "Confirm"
# Then a teaching should exist with klass: klass "20", teacher: user "prince", status_mask: 2
# And 1 teachings should exist
# And I should see "You cannot confirm an already declined class." as error flash message
# And I should see no notice flash message
# And I should be redirected to the confirm page for user: "prince"

# #In order to make this test work, you have to comment out
# #current in the users_controller!
# @not_current
# Scenario: A teacher should not be able to confirm a class that is not current
# Given a klass: "18" exists with date: "2010-03-18"
# And a teaching exists with klass: klass "18", teacher: user "prince", current: false
# And a user is logged in as "johan"
# When I go to the confirm page for user: "prince" on "2010-03-06"
# And I confirmed the klass
# And I press "Confirm"
# Then a teaching should exist with klass: klass "18", teacher: user "prince", current: false, status_mask: 4
# And 1 teachings should exist
# And I should see "You cannot confirm a class you do not have." as error flash message
# And I should see no notice flash message
# And I should be redirected to the confirm page for user: "prince"

# #In order to make this test work, you have to comment out
# #the date condition in the users_controller!
# @too_late
# Scenario: A teacher should not be able to confirm a class after it has started
# Given a klass: "18" exists with date: "2010-03-18"
# And a teaching exists with klass: that klass, teacher: user "prince"
# And a user is logged in as "prince"
# When I go to the confirm page for user: "prince"
# And I confirmed the klass
# And I press "Confirm"
# Then a teaching should exist with klass: klass "18", teacher: user "prince", status_mask: 4
# And 1 teachings should exist
# And I should see "You cannot confirm a class that already is over." as error flash message
# And I should see no notice flash message
# And I should be redirected to the confirm page for user: "prince"

@pending
Scenario: Create expetion messages for those classes with I18n

@pending
Scenario: Don't show a flash message saying confirmation was successful if it wasn't

@pending
Scenario: Take the beginning_of_day out of todays date and apply it to the search, only
