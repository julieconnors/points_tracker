class Point < ActiveRecord::Base
    belongs_to :horse
    belongs_to :horseShow
end