class ChangeRankColumnNameInEntries < ActiveRecord::Migration
  def change
    rename_column :entries, :rank, :lastfm_top_all
  end
end
