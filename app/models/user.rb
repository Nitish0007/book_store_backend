class User < ApplicationRecord
    has_secure_password
    has_many :orders
    has_many :jtis

    validates :email, presence: true, uniqueness: true
    validates :username, presence: true, uniqueness: true
    validates :password, presence: true
    validates :is_admin, presence: true


end

