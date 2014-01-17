class AddIdEchnoestToArtists < ActiveRecord::Migration
  def change
    add_column :artists, :id_echonest, :string
  end
end
