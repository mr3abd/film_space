# == Schema Information
#
# Table name: movie_filming_locations
#
#  id                  :bigint           not null, primary key
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  filming_location_id :bigint           not null
#  movie_id            :bigint           not null
#
# Indexes
#
#  index_movie_filming_locations_on_filming_location_id  (filming_location_id)
#  index_movie_filming_locations_on_movie_id             (movie_id)
#
# Foreign Keys
#
#  fk_rails_...  (filming_location_id => filming_locations.id)
#  fk_rails_...  (movie_id => movies.id)
#
class MovieFilmingLocation < ApplicationRecord
  belongs_to :movie
  belongs_to :filming_location
end
