class Movie < ApplicationRecord
  belongs_to :director
  belongs_to :actor
  belongs_to :filming_location
  belongs_to :country
end
