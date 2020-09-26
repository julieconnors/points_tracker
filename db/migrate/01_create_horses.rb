class CreateHorses < ActiveRecord::Migration
    def change
        create_table :horses do |t|
            t.string :name
            t.integer :point_total
            t.integer :user_id
        end
    end
end