class Prize < ActiveRecord::Base
    belongs_to :horse
    belongs_to :horseshow
    belongs_to :user

end