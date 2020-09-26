class CreatePoints < ActiveRecord::Migration
    def change
        create_table :points do |t|
            t.integer :total
            t.integer :horse_id
            t.integer :horse_show_id
        end
    end
end