class CreateHorseShows < ActiveRecord::Migration
    def change
        create_table :horse_shows do |t|
            t.string :name
            t.string :location
        end
    end
end