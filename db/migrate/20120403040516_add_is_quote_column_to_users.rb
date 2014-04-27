class AddIsQuoteColumnToUsers < ActiveRecord::Migration
  def change
    add_column :users, :is_quote, :boolean, :default => false
  end
end
