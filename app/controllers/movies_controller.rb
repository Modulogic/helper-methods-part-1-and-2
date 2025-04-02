class MoviesController < ApplicationController
  def new
    @the_movie = Movie.new

  end

  def index
    @movies = Movie.order(created_at: :desc)

    respond_to do |format|
      format.json do
        render json: @movies
      end

      format.html
    end
  end

  def show
    @movie = Movie.find(params.fetch(:id))
  end

  def create
    movie_attributes = params.require(:movie).permit(:title, :description)
    @movie = Movie.new(movie_attributes)

    if @movie.valid?
      @movie.save
      redirect_to movies_path, notice: "Movie was successfully created."
    else
      render template: "movies/new"
    end
  end

  def edit
    the_id = params.fetch(:id)

    matching_movies = Movie.where({ id: the_id })

    @the_movie = matching_movies.first

  end

  def update
    the_id = params.fetch(:id)
    the_movie = Movie.where({ id: the_id }).first

    @movie.title = params.fetch(:title)
    @movie.description = params.fetch(:description)

    if the_movie.valid?
      the_movie.save
      redirect_to movie_url(the_movie), notice: "Movie updated successfully." 
    else
      redirect_to movie_url(the_movie), alert: "Movie failed to update successfully." 
    end
  end

  def destroy
    the_id = params.fetch(:id)
    the_movie = Movie.where({ id: the_id }).first

    the_movie.destroy

    redirect_to(movies_url, { notice: "Movie deleted successfully." })
  end
end
