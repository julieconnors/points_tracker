class AddDateColumnToPrizes < ActiveRecord::Migration
    def change
        add_column :prizes, :date, :string
    end
end