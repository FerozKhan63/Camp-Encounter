class Location < ApplicationRecord
  include PgSearch::Model

  has_many :camp_locations, dependent: :destroy
  has_many :camps, through: :camp_locations

  pg_search_scope :global_search, against: [:name], using: { tsearch: { prefix: true } }

  AlPHABETS_ONLY = /\A[a-zA-Z_ ]+\z/

  validates :name, presence: true , length: { minimum: 2 }, format: { with: AlPHABETS_ONLY, message: "only allows letters" }

  private

  def self.to_csv
    attributes = %w{ id name }
    csv = ExportToCsv.create_csv_file(attributes, self)
  end
end
