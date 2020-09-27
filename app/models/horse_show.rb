class HorseShow < ActiveRecord::Base
    has_many :prizes
    has_many :horses, through: :prizes
end