class CreateCampLocations < ActiveRecord::Migration[6.1]
  def change
    create_table :camp_locations do |t|
      t.belongs_to :camp
      t.belongs_to :location
      t.timestamps
    end
  end
end
