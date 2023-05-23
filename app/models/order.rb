class Order < ApplicationRecord
    belongs_to :user
    has_one :book
    belongs_to :cart
    belongs_to :order_list
end
