class Horse < ActiveRecord::Base
    #extend Slugify::ClassMethods
    #include Slugify::InstanceMethods
    
    belongs_to :user
    has_many :prizes
    has_many :horseshows, through: :prizes

    def point_total
        point_list = self.prizes.map{|prize| prize.point_total}
        point_list.sum
    end

    def slug
        self.name.downcase.gsub(" ", "-")
    end

    def self.find_by_slug(slug)
        self.all.find { |horse| horse.slug == slug }
    end
end