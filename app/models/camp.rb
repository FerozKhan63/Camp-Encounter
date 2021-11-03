require 'csv'
class Camp < ApplicationRecord
  include PgSearch::Model
  
  belongs_to :user, optional: true

  pg_search_scope :global_search, against: [:name, :location], using: { tsearch: { prefix: true } }
  
  validates :name, presence: true , length: { minimum: 2 }, format: { with: /\A[a-zA-Z]+\z/, message: "only allows letters" }

  private

  def self.to_csv
    attributes = %w{ name location status registration_date }

    CSV.generate(headers: true) do |csv|
      csv << attributes

      all.each do |camp|
        csv << attributes.map{ |attr| camp.send(attr) }
      end
    end
  end

end
