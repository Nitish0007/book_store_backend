class SendEmailWorkerJob
  include Sidekiq::Job

  def perform(user_id, order)
    user = User.find(user_id)
    NotifierMailer.order_placed_notifier(user, order).deliver_now
  end
end
