class AddCostToCamps < ActiveRecord::Migration[6.1]
  def change
    add_column :camps, :cost, :float
  end
end
