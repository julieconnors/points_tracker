class Points < ActiveRecord::Base
    belongs_to :horse
    belongs_to :horse_show
end