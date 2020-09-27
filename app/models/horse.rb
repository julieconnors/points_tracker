class Horse < ActiveRecord::Base
    belongs_to :user
    has_many :points
    has_many :horseShows, through: :points

    def point_total
        point_list = self.points.map{|point| point.total}
        point_list.sum
    end
end