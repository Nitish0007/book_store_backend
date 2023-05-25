class Book < ApplicationRecord
    has_many :orders
    validates :name, :author, :price , presence: true
    validates :name, uniqueness: true
end
