class EnrolmentSerializer < ActiveModel::Serializer
  attributes :id, :gender, :age, :camp_options, :tent_sharing, :emergency_contact,
             :medical_history, :blood_group, :cnic, :billing_address, :mailing_address,
             :experience, :progress, :submitted, :insurance, :user_id, :camp_id
end
