class CreateHorseShows < ActiveRecord::Base
    def change
        create_table :horse_shows do |t|
            t.string :name
            t.string :location
        end
    end
end