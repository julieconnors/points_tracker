class AddUserIdColumnToHorses < ActiveRecord::Migration
    def change
        add_column :horses, :user_id, :integer
    end
end