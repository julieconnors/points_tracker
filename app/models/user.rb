class User < ActiveRecord::Base
    has_many :prizes
    has_many :horses
    has_many :horseshows, through: :horses
    has_secure_password
    validates_presence_of :username, :password, :name

    def list_horse_shows #finds unique horseshows for a specific user
        self.horseshows.map{|show| show.name}.uniq
    end

    def slug
        self.username.downcase.gsub(" ", "-")
    end

    def self.find_by_slug(slug)
        self.all.find { |user| user.slug == slug }
    end
end