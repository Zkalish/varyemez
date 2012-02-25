class CreateCredits < ActiveRecord::Migration
  def change
    create_table :credits do |t|
      t.integer :contact_id
      t.float :amount
      t.integer :credit_type
      t.date :date_from
      t.date :date_to

      t.timestamps
    end
  end
end
