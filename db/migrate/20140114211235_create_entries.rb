class CreateEntries < ActiveRecord::Migration
  def change
    create_table :entries do |t|

      t.integer   :user_id
      t.integer   :artist_id
      t.integer   :rank

      t.timestamps
    end
  end
end
