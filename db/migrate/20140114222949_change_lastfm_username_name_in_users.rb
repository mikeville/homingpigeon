class ChangeLastfmUsernameNameInUsers < ActiveRecord::Migration
  def change
        rename_column :users, :lastfm_username, :username_lastfm
  end
end
