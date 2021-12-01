class Enrolment < ApplicationRecord
  belongs_to :user
  belongs_to :camp

  has_rich_text :medical_history 
  has_rich_text :experience

  BLOODGROUPS = ["A+", "B+", "AB+", "A-", "B-", "AB-", "O-", "O+"]

  def completed?
    progress == 100
  end
  
end
