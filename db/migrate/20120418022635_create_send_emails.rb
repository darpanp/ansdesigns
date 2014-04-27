class CreateSendEmails < ActiveRecord::Migration
  def change
    create_table :send_emails do |t|
      t.string :customer_id
      t.string :order_id
      t.string :is_quote
      t.date :reminder_date
      
      t.timestamps
    end
  end
end
