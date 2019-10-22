class Movie < ActiveRecord::Base
  def self.all_ratings
    %w(G PG PG-13 NC-17 R)
  end
  
  def self.similar_movies(movie)
    movie_director = movie.director
    return nil if(movie_director.nil?)
    Movie.where(director: movie_director)
  end
end
