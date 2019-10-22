require 'rails_helper'
describe MoviesController do
    fixtures :movies
    describe 'Search similar movies by director' do
        it 'Should call the find method in Movie to get the current movie director' do
            movie = movies(:luca)
            Movie.should_receive(:find).with(movie.id.to_s).and_return(movie)
            get :similar, {:id => movie.id}
        end
        it 'Should invoke the similar_movies function in Movie' do
            similar_movies = [movies(:luca), movies(:mayanadhi)]
            movie = movies(:luca)
            Movie.should_receive(:similar_movies).with(movie).and_return(similar_movies)
            get :similar, {:id => movie.id}
        end
        it 'Should render the similar movies template if director exists' do
            movie = movies(:luca)
            get :similar, {:id => movie.id}
            expect(response).to render_template('similar')
        end
        it 'Should redirect to the rotten potatoes home page if director does not exist' do
            movie = movies(:niram)
            Movie.should_receive(:similar_movies).with(movie).and_return(nil)
            get :similar, {:id => movie.id}
            expect(response).to redirect_to('/movies')
        end
        it 'Should pass the similar movies to the similar movies template' do
            similar_movies = [movies(:luca), movies(:mayanadhi)]
            movie = movies(:luca)
            Movie.stub(:similar_movies).with(movie).and_return(similar_movies)
            get :similar, {:id => movie.id}
            expect(assigns(:movies)).to eql(similar_movies)
        end
    end
    
    describe 'Create new movie' do
        it 'Should invoke create function in Movie' do
            movie = movies(:luca)
            Movie.should_receive(:create!).with({:title => 'Luca'}).and_return(movie)
            post :create, {:movie => {:title => 'Luca'}}
        end
        it 'Should display a message that the movie was created' do
            movie = movies(:luca)
            Movie.stub(:create!).with({:title => 'Luca'}).and_return(movie)
            post :create, {:movie => {:title => 'Luca'}}
            expect(flash[:notice]).to be_present
        end
        it 'Should redirect to the rotten potatoes home page after creation of new movie' do
            movie = movies(:luca)
            Movie.stub(:create!).with({:title => 'Luca'}).and_return(movie)
            post :create, {:movie => {:title => 'Luca'}}
            expect(response).to redirect_to('/movies')
        end
    end
    
    describe 'Edit a movie' do
        it 'Should invoke find function in Movie' do
            movie = movies(:luca)
            Movie.should_receive(:find).with(movie.id.to_s).and_return(movie)
            get :edit, {:id => movie.id}
        end
    end
    
    describe 'Update a movie' do
        it 'Should invoke find function in Movie' do
            movie = movies(:luca)
            Movie.should_receive(:find).with(movie.id.to_s).and_return(movie)
            put :update, {:movie => {:title => 'Luca2'}, :id => movie.id}
        end
        it 'Should display a message that the movie was updated' do
            movie = movies(:luca)
            movie.stub(:update_attributes!).with({:title => 'Luca'})
            put :update, {:movie => {:title => 'Luca'}, :id => movie.id}
            expect(flash[:notice]).to be_present
        end
        it 'Should redirect to the movie page after updation of the movie' do
            movie = movies(:luca)
            movie.stub(:update_attributes!).with({:title => 'Luca'})
            put :update, {:movie => {:title => 'Luca2'}, :id =>movie.id}
            expect(response).to redirect_to('/movies/'+movie.id.to_s)
        end
    end
    
    describe 'Show a movie' do
        it 'Should invoke find function in Movie' do
            movie = movies(:luca)
            Movie.should_receive(:find).with(movie.id.to_s).and_return(movie)
            get :show, {:id => movie.id}
        end
    end
    
    describe 'Delete a movie' do
        it 'Should invoke find function in Movie' do
            movie = movies(:luca)
            Movie.should_receive(:find).with(movie.id.to_s).and_return(movie)
            delete :destroy, {:id => movie.id}
        end
        it 'Should display a message that the movie was deleted' do
            movie = movies(:luca)
            movie.stub(:destroy)
            delete :destroy, {:id => movie.id}
            expect(flash[:notice]).to be_present
        end
        it 'Should redirect to the rotten potatoes home page after deletion of the movie' do
            movie = movies(:luca)
            movie.stub(:destroy)
            delete :destroy, {:id => movie.id}
            expect(response).to redirect_to('/movies')
        end
    end
    
    describe 'Index page of movies' do
        it 'Should invoke all ratings function of Movies' do
            ratings = %w(G PG PG-13 NC-17 R)
            Movie.should_receive(:all_ratings).and_return(ratings)
            get :index
        end
        it 'Should render index template' do
            ratings = %w(G PG PG-13 NC-17 R)
            Movie.stub(:all_ratings).and_return(ratings)
            get :index
            expect(response).to render_template('index')
        end
    end
end