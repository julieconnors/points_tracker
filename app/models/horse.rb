class Horse < ActiveRecord::Base
    belongs_to :user
    has_many :prizes
    has_many :horseshows, through: :prizes

    def point_total #sums the point_total attribute from all prizes belonging to a horse
        point_list = self.prizes.map{|prize| prize.point_total}
        point_list.sum
    end

    def point_total_by_horseshow(show_id) #find a horse's point total from a particular show
        self.prizes.find{|prize| prize.horseshow_id == show_id}.point_total
    end

    def slug
        self.name.downcase.gsub(" ", "-")
    end

    def self.find_by_slug(slug)
        self.all.find { |horse| horse.slug == slug }
    end

    def horses_sorted_horseshows #sorts horseshows by date
        self.horseshows.order(:date)
    end
end