# == Schema Information
#
# Table name: movies
#
#  id          :bigint           not null, primary key
#  description :text
#  name        :string
#  year        :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  director_id :bigint           not null
#
# Indexes
#
#  index_movies_on_director_id  (director_id)
#
# Foreign Keys
#
#  fk_rails_...  (director_id => directors.id)
#
class Movie < ApplicationRecord
  include Filterable

  belongs_to :director

  has_many :movie_actors
  has_many :actors, through: :movie_actors

  has_many :movie_filming_locations
  has_many :filming_locations, through: :movie_filming_locations

  has_many :movie_countries
  has_many :countries, through: :movie_countries

  has_many :reviews

  scope :filter_by_active_sort_rating, ->(rating) {
    return nil unless rating
    select('movies.*, AVG(reviews.stars) AS average_stars')
      .joins(:reviews)
      .group('movies.id')
      .order('average_stars DESC')
  }
  scope :filter_by_actor_name, ->(actor_name) { joins(:actors).where('actors.name ILIKE ?', "%#{actor_name}%").distinct }


end
