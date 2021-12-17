class AddBraintreeToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :braintree_customer_id, :string
    add_column :users, :braintree_id, :string
  end
end
