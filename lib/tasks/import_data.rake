namespace :import do
  desc 'Import movies and reviews from CSV files'
  task data: :environment do
    require 'csv'

    def find_or_create_director(name)
      Director.find_or_create_by(name: name)
    end

    def find_or_create_actor(name)
      Actor.find_or_create_by(name: name)
    end

    def find_or_create_filming_location(name)
      FilmingLocation.find_or_create_by(name: name)
    end

    def find_or_create_country(name)
      Country.find_or_create_by(name: name)
    end

    def find_or_create_user(name)
      User.find_or_create_by(name: name)
    end

    def find_or_create_movie(data)
      Movie.find_or_create_by(
        name: data['Movie'],
        director: find_or_create_director(data['Director']),
        description: data['Description'],
        year: data['Year']
      )
    end

    def add_actor_filming_location_country(movie, actor, filming_location, country)
      movie.actors << actor unless movie.actors.exists?(actor.id)
      movie.filming_locations << filming_location unless movie.filming_locations.exists?(filming_location.id)
      movie.countries << country unless movie.countries.exists?(country.id)
    end

    def import_movies
      CSV.foreach(Rails.root.join('lib', 'data', 'movies.csv'), headers: true) do |row|
        puts 'Data for movies'
        data = row.to_h
        movie = find_or_create_movie(data)
        add_actor_filming_location_country(
          movie,
          find_or_create_actor(data['Actor']),
          find_or_create_filming_location(data['Filming location']),
          find_or_create_country(data['Country'])
        )
      end
    end

    def import_reviews
      CSV.foreach(Rails.root.join('lib', 'data', 'reviews.csv'), headers: true) do |row|
        puts 'Data for reviews'
        data = row.to_h
        Review.create!(
          movie: find_or_create_movie(data),
          user: find_or_create_user(data['User']),
          stars: data['Stars'],
          review: data['Review']
        )
      end
    end

    import_movies
    import_reviews
  end
end
