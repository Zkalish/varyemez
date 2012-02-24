class AddOauthProviderAndOauthUidToUsers < ActiveRecord::Migration
  def change
    add_column :users, :oauth_provider, :string

    add_column :users, :oauth_uid, :string

  end
end
