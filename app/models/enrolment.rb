class Enrolment < ApplicationRecord
  belongs_to :user
  belongs_to :camp

  BLOODGROUPS = ["A+", "B+", "AB+", "A-", "B-", "AB-", "O-", "O+"]
  
end
