class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :customer_id
      t.string :order_id
      t.boolean :is_quote, :default => false 
      t.string :order_type
      t.string :order_density
      t.string :order_qty_or_hour
      t.string :price_per_qty_or_hour
      t.string :order_status
      t.string :order_subtotal
      
      t.timestamps
    end
  end
end
