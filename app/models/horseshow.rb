class Horseshow < ActiveRecord::Base
    has_many :prizes
    has_many :horses, through: :prizes

    def format_date #changes the date format from the form input
        Date.parse(self.date).strftime('%-m/%d/%y')
    end

    def sort_by_points
        self.prizes.order(point_total: :desc)
    end
end