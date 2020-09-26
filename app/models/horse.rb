class Horse < ActiveRecord::Base
    belongs_to :user
    has_many :points
    has_many :horseShows, through: :points
end