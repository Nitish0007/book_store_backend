class Book < ApplicationRecord
    belongs_to :order

    validates :name, :author, :price , presence: true
    validates :name, uniqueness: true
end
