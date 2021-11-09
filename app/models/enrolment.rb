class Enrolment < ApplicationRecord
  belongs_to :user
  belongs_to :camp

  BlOODGROUPS = ["A+","B+","AB+","A-","B-","AB-","O-","O+"]
end
