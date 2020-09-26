class HorseShow < ActiveRecord::Base
    has_many :points
    has_many :horses, through: :points
end