class Horse < ActiveRecord::Base
    belongs_to :user
    has_many :points
    has_many :points, through: :horse_shows
end