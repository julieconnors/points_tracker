class Prize < ActiveRecord::Base
    belongs_to :horse
    belongs_to :horseshow
    belongs_to :user

    validates :point_total, numericality: { only_integer: true }

end