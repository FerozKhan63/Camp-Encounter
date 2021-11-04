require 'csv'

class Camp < ApplicationRecord
  include PgSearch::Model
  
  belongs_to :user, optional: true
 
  LOCATIONS = ['Kenya', 'Pakistan', "South Africa", "Egypt", "Alaska"].freeze

  pg_search_scope :global_search, against: [:name, :location], using: { tsearch: { prefix: true } }
  
  validates :name, presence: true , length: { minimum: 5 }, format: { with: /\A[a-zA-Z]+\z/, message: "only allows letters" }
  validates :end_date, :start_date, presence: true
  validate :end_date_after_start_date? 
  validate :start_date_before_reg_date?

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

  def end_date_after_start_date?
    if self.end_date < self.start_date
      errors.add :end_date, "must be after start date"
    end
  end

  def start_date_before_reg_date?
    if self.start_date < self.registration_date
      errors.add :start_date, "must be after registration date"
    end
  end
end
