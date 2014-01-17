class AddFbTokenColumnAndFbNicknameColumnToUsers < ActiveRecord::Migration
  def change
    add_column :users, :fb_token, :string
    add_column :users, :fb_nickname, :string
  end
end