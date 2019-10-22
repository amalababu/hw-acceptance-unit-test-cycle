Feature: update title of a movie

  As a movie buff
  So that update a movie name
  I want to update the title of a moviw

Background: movies in database

  Given the following movies exist:
  | title        | rating | director     | release_date |
  | Star Wars    | PG     | George Lucas |   1977-05-25 |
  | Blade Runner | PG     | Ridley Scott |   1982-06-25 |
  | Alien        | R      |              |   1979-05-25 |
  | THX-1138     | R      | George Lucas |   1971-03-11 |

Scenario: update title of existing movie
  When I go to the edit page for "Alien"
  And  I fill in "Title" with "Alien Invasion"
  And  I press "Update Movie Info"
  Then I should see "Alien Invasion"