class Horseshow < ActiveRecord::Base
    has_many :prizes
    has_many :horses, through: :prizes

    def slug
        self.name.downcase.gsub(" ", "-")
    end

    def self.find_by_slug(slug)
        self.all.find { |horseshow| horseshow.slug == slug }
    end
end