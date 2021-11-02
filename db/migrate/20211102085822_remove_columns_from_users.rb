class RemoveColumnsFromUsers < ActiveRecord::Migration[6.1]
  def change
    remove_column :users, :invitation_token, :string
    remove_column :users, :invitation_created_at, :datetime
    remove_column :users, :invitation_sent_at, :datetime
    remove_column :users, :invitation_accepted_at, :datetime
    remove_column :users, :invitation_limit, :integer
    remove_column :users, :invited_by_id, :integer
    remove_column :users, :invited_by_type, :string
  end
end
