class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :lastfm_username

      t.timestamps
    end
  end
end
