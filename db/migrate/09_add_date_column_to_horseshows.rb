class AddDateColumnToHorseshows < ActiveRecord::Migration
    def change
        add_column :horseshows, :date, :string
    end
end