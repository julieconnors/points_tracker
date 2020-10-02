class AddUserIdToPrizes < ActiveRecord::Migration
    def change
        add_column :prizes, :user_id, :integer
    end
end