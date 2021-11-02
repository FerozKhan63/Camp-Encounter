class CreateCamps < ActiveRecord::Migration[6.1]
  def change
    create_table :camps do |t|

      t.timestamps
    end
  end
end
