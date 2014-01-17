class RemoveUserAndArtistAndLastfmTopFromLists < ActiveRecord::Migration
  def change
    remove_column :lists, :artist_id
    remove_column :lists, :user_id
    remove_column :lists, :lastfm_top
  end
end
