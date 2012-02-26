class AddDebtToContacts < ActiveRecord::Migration
  def change
    add_column :contacts, :debt, :float, :default => 0.0

  end
end
