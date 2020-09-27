class CreatePrizes < ActiveRecord::Migration
    def change
        create_table :prizes do |t|
            t.integer :point_total
            t.integer :horse_id
            t.integer :horse_show_id
        end
    end
end