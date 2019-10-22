require 'rails_helper'
describe Movie do
    fixtures :movies
    describe 'Search similar movies by director' do
        it 'Should return a list of similar movies with the same director' do
            movie = movies(:luca)
            similar_movies = [movies(:luca), movies(:mayanadhi)]
            expect(Movie.similar_movies(movie).to_a).to eql(similar_movies)
        end
        it 'Should return nil for a movie with no director' do
            movie = movies(:niram)
            expect(Movie.similar_movies(movie)).to eql(nil)
        end
        it 'Should not return a movie with dissimilar director' do
            movie = movies(:luca)
            expect(Movie.similar_movies(movie)).to_not include(movies(:niram))
        end
    end   
    
    describe 'Return all ratings' do
        it 'Should return all ratings' do
            ratings = %w(G PG PG-13 NC-17 R)
            expect(Movie.all_ratings).to eql(ratings)
        end
    end
end