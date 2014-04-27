class CreateContactUs < ActiveRecord::Migration
  def change
    create_table :contact_us do |t|
      t.string :name
      t.string :email
      t.string :subject
      t.text :message
      t.string :user_ip
      t.string :user_agent
      t.string :referrer

      t.timestamps
    end
  end
end
