class Location < ApplicationRecord
  has_many :camp_locations
  has_many :camps, through: :camp_locations
end
