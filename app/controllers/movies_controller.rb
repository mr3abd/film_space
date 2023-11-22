class MoviesController < ApplicationController
  def index
    # cancel old pagy logic fix it later
    # @pagy, @movies = pagy(Movie.filter(filtering_params))
    @movies = Movie.filter(filtering_params)

  end

  private

  def filtering_params
    # in-case add more filters by filterable
    params.slice(:actor_name, :active_sort_rating)
  end
end
