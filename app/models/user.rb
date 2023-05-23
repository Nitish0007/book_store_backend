class User < ApplicationRecord
    # before_destroy :delete_dependencies

    has_secure_password
    has_one :cart, dependent: :destroy
    has_many :orders
    has_one :order_list, dependent: :destroy

    validates :email, presence: true, uniqueness: true
    validates :username, presence: true, uniqueness: true
    validates :password, presence: true
    validates :is_admin, presence: true

    private

    # def delete_dependencies
    #     cart = Cart.find(@user.cart_id)
    #     cart.destroy if cart
    #     order_list = OrderList.find(@user.order_list_id)
    #     order_list.destroy if order_list
    # end

end

