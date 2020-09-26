class User < ActiveRecord::Base
    has_many :horses
    has_secure_password

end