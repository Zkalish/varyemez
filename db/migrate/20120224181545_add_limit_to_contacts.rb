class AddLimitToContacts < ActiveRecord::Migration
  def change
    add_column :contacts, :limit, :integer

  end
end
