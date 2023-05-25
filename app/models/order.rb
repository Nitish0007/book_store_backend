class Order < ApplicationRecord
    belongs_to :user
    belongs_to :book
    belongs_to :cart
end
