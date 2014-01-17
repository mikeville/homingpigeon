class Entry < ActiveRecord::Base
  attr_accessible :artist_id, :user_id, :lastfm_top_all

  belongs_to :artist
  belongs_to :user

end
