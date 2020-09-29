class User < ActiveRecord::Base
    has_many :horses
    has_many :horseshows, through: :horses
    has_secure_password
    validates_presence_of :username, :password

    def list_horse_shows
        self.horseshows.map{|show| show.name}.uniq
    end
end