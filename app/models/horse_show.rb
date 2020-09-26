class HorseShow < ActiveRecord::Base
    has_many :points
    has_many :points, through: :horses
end