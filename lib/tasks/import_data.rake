namespace :import do
  desc "Import movies and reviews from CSV files"
  task :data => :environment do
    require 'csv'

    # Import movies
    CSV.foreach(Rails.root.join('lib', 'data', 'movies.csv'), headers: true) do |row|
      p " data for movies"
      data = row.to_h
      # Movie.create!(row.to_h)
      # convert movie to name
      data[:name] = data['Movie']
      # find_or_create for (Director - Actor - FilmingLocation - Country)
      data[:director] = Director.find_or_create_by(name: data['Director'])
      data[:actor] = Actor.find_or_create_by(name: data['Actor'])
      data[:filming_location] = FilmingLocation.find_or_create_by(name: data['Filming location'])
      data[:country] = Country.find_or_create_by(name: data['Country'])
      movie = Movie.find_by_name(data[:name])
      unless movie
        movie =  Movie.create({
          name: data[:name], director: data[:director],
          description: data['Description'],
          year: data['Year']
        })

      end
      movie.actors << data[:actor] unless  movie.actors.map(&:id).include? data[:actor].id
      movie.filming_locations << data[:filming_location] unless movie.filming_locations.map(&:id).include? data[:filming_location].id
      movie.countries << data[:country]  unless movie.countries.map(&:id).include? data[:country].id
    end

    # Import reviews
    CSV.foreach(Rails.root.join('lib', 'data', 'reviews.csv'), headers: true) do |row|
      # Review.create!(row.to_h)
      # find_or_create_by Movie or User
      p "data for reviews "
      data = row.to_h
      data[:user] = User.find_or_create_by(name: data['User'])
      data[:movie] = Movie.find_or_create_by(name: data['Movie'])
      Review.create!({
        movie: data[:movie], user: data[:user],
        stars: data['Stars'], review: data['Review']
      })

    end
  end
end
