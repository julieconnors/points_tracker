class CreateHorses < ActiveRecord::Base
    def change
        create_table :horses do |t|
            t.string :name
            t.integer :point_total
        end
    end
end