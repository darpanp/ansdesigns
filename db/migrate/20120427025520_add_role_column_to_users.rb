class AddRoleColumnToUsers < ActiveRecord::Migration
  def change
    add_column :users, :user_role, :string, :default => "CUSTOMER"
  end
end
