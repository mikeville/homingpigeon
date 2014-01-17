class Artist < ActiveRecord::Base
  attr_accessible :name, :twitter_handle, :id_echonest

  has_many :entries








  
end
