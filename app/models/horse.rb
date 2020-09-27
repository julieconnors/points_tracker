class Horse < ActiveRecord::Base
    belongs_to :user
    has_many :prizes
    has_many :horseShows, through: :prizes

    def point_total
        point_list = self.prizes.map{|prize| prize.point_total}
        point_list.sum
    end
end