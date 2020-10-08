class User < ActiveRecord::Base
    has_many :prizes
    has_many :horses
    has_many :horseshows, through: :horses
    has_secure_password
    validates_presence_of :username, :password, :name

    def list_horse_shows #finds unique horseshows for a specific user
        self.horseshows.map{|show| show.name}.uniq
    end

    def point_total_by_horseshow(show_id) #find a users's point total from a particular show
        self.prizes.select{|prize| prize.horseshow_id == show_id}.map{|prize| prize.point_total}.sum
    end

    def slug
        self.username.downcase.gsub(" ", "-")
    end

    def self.find_by_slug(slug)
        self.all.find { |user| user.slug == slug }
    end
end