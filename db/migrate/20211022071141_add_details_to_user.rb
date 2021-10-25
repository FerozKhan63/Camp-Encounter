class AddDetailsToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users,:first_name, :string
    add_column :users,:last_name, :string
    add_column :users,:country, :string
    add_column :users,:phone_number, :string
    add_column :users,:country_code, :string
  end
end
