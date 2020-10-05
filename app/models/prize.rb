class Prize < ActiveRecord::Base
    belongs_to :horse
    belongs_to :horseshow
    belongs_to :user

    #validates :point_total, numericality: { only_integer: true } I may not need this validation if I am checking for validation from user input

end