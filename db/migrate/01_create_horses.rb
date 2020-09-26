class CreateHorses < ActiveRecord::Migration
    def change
        create_table :horses do |t|
            t.string :name
            t.integer :point_total
        end
    end
end