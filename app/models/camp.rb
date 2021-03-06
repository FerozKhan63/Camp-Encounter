class Camp < ApplicationRecord
  include PgSearch::Model

  has_many :enrolments
  has_many :users, through: :enrolments
  has_many :camp_locations, dependent: :destroy
  has_many :locations, through: :camp_locations

  pg_search_scope :global_search, against: [:name, :status], using: { tsearch: { prefix: true } }

  ALPHABETS_ONLY = /\A[a-zA-Z_ ]+\z/
  ACTIVE = :active
  INACTIVE = :inactive
  STATUS = [ACTIVE, INACTIVE]

  enum status: STATUS, _default: :active
  
  validates :name, presence: true , length: { minimum: 2 }, format: { with: ALPHABETS_ONLY, message: "only allows letters" }
  validates :end_date, :start_date, presence: true
  validate :end_date_after_start_date? 
  validate :start_date_before_reg_date?

  private

  def self.attributes
    %w{ name location status registration_date }
  end

  def end_date_after_start_date?
    if !end_date.nil? && !start_date.nil?
      if end_date < start_date
        errors.add :end_date, "must be after start date"
      end
    end
  end

  def start_date_before_reg_date?
    if !end_date.nil? && !registration_date.nil?
      if end_date < registration_date
        errors.add :start_date, "must be after registration date"
      end
    end
  end

  def location
    self.locations.each do |location|
      location.name  
    end 
  end
end
