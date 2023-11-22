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

      Movie.create!({
        name: data[:name], director: data[:director], actor: data[:actor],
        filming_location: data[:filming_location], description: data['Description'],
        country: data[:country], year: data['Year']
      })
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
