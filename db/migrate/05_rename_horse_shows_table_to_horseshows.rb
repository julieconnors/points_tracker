class RenameHorseShowsTableToHorseshows < ActiveRecord::Migration
    def change
        rename_table :horse_shows, :horseshows
    end
end