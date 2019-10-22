Feature: delete a movie
 
 As a movie-goer 
 So that I can update the rotten potatoes page
 I want to delete a movie

Background: movies in database

  Given the following movies exist:
  | title        | rating | director     | release_date |
  | Star Wars    | PG     | George Lucas |   1977-05-25 |
  | Blade Runner | PG     | Ridley Scott |   1982-06-25 |
  | Alien        | R      |              |   1979-05-25 |
  | THX-1138     | R      | George Lucas |   1971-03-11 |
  
Scenario: delete a movie from the database
  Given I am on the details page for "Star Wars"
  And  I press "Delete"
  Then I should see "Movie 'Star Wars' deleted"