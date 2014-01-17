class CreateLists < ActiveRecord::Migration
  def change
    create_table :lists do |t|
      t.integer :user_id
      t.integer :artist_id
      t.integer :lastfm_top

      t.timestamps
    end
  end
end
