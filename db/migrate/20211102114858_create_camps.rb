class CreateCamps < ActiveRecord::Migration[6.1]
  def change
    create_table :camps do |t|
      t.string :name
      t.datetime :start_date
      t.datetime :end_date
      t.text :locations, array: true, default: []
      t.datetime :registration_date
      t.integer :status
      t.references :user
      
      t.timestamps
    end
  end
end
