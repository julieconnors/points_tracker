class User < ActiveRecord::Base
    has_many :horses
    has_secure_password
    validates_presence_of :username, :password

    def list_horse_shows
        horse_shows = []
        self.horses.each do |horse|
            horse.horseshows.each do |horseshow|
                horse_shows << horseshow.name
            end
        end
        horse_shows.uniq
    end
end