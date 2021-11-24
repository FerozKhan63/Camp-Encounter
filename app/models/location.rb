class Location < ApplicationRecord
  include PgSearch::Model

  has_many :camp_locations, dependent: :destroy
  has_many :camps, through: :camp_locations

  pg_search_scope :global_search, against: [:name], using: { tsearch: { prefix: true } }

  ALPHABETS_ONLY = /\A[a-zA-Z]+\z/

  validates :name, presence: true , length: { minimum: 2 }, format: { with: ALPHABETS_ONLY, message: "only allows letters" }

  private

  def self.attributes
    attributes = %w{ id name }
  end
end
