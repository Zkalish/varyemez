class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.integer :user_id
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :sex
      t.string :phone
      t.boolean :lock

      t.timestamps
    end
  end
end
