class AddCustomerIdUniquenessIndex < ActiveRecord::Migration
  def up
    add_index :users, :customer_id, :unique => true
  end

  def down
    remove_index :users, :customer_id
  end
end
