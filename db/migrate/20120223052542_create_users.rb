class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :password
      t.string :email
      t.string :fullname
      t.string :company

      t.timestamps
    end
  end
end
