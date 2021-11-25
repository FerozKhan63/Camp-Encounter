class RemoveUserFromCamps < ActiveRecord::Migration[6.1]
  def change
    remove_reference :camps, :user, index: true
  end
end
