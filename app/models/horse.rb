class Horse < ActiveRecord::Base
    belongs_to :user
    has_many :prizes
    has_many :horseshows, through: :prizes

    def point_total
        point_list = self.prizes.map{|prize| prize.point_total}
        point_list.sum
    end

    def horse_show_list
        show_ids = self.prizes.map{|prize| prize.horse_show_id}
        show_ids.map do |id|
            HorseShow.find(id).name
        end
    end
end