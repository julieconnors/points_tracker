class User < ActiveRecord::Base
    has_many :prizes
    has_many :horses
    has_many :horseshows, through: :horses
    has_secure_password
    validates_presence_of :username, :password

    def list_horse_shows
        self.horseshows.map{|show| show.name}.uniq
    end

    def slug
        self.name.downcase.gsub(" ", "-")
    end

    def self.find_by_slug(slug)
        self.all.find { |horseshow| horseshow.slug == slug }
    end
end