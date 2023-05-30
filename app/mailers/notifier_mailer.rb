class NotifierMailer < ApplicationMailer
    def order_placed_notifier(user, order)
        @user = user
        @order = JSON.parse(order)
        mail(to: 'nitish.s@maropost.com', subject: "Your Order placed successfully")
    end
end
