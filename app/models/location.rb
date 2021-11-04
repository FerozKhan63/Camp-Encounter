class Location < ApplicationRecord
  has_many :camp_locations, dependent: :destroy
  has_many :camps, through: :camp_locations
end
