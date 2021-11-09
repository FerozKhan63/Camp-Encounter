class AddColumnsToEnrolments < ActiveRecord::Migration[6.1]
  def change
    add_column :enrolments, :age, :integer
    add_column :enrolments, :gender, :string
    add_column :enrolments, :mailing_address, :string
    add_column :enrolments, :billing_address, :string
    add_column :enrolments, :emergency_contact, :string
    add_column :enrolments, :cnic, :string
    add_column :enrolments, :medical_history, :text
    add_column :enrolments, :experience, :text
    add_column :enrolments, :tent_sharing, :boolean
    add_column :enrolments, :camp_options, :string
    add_column :enrolments, :progress, :integer, default: 0
    add_column :enrolments, :blood_group, :string
    add_column :enrolments, :insurance, :boolean
    add_column :enrolments, :submitted, :boolean
  end
end
