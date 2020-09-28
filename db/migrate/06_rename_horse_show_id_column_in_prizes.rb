class RenameHorseShowIdColumnInPrizes < ActiveRecord::Migration
    def change
        rename_column :prizes, :horse_show_id, :horseshow_id
    end
end