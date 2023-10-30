class SetupDeliveryWorker
  include Sidekiq::Worker

  sidekiq_options retry: 5

  def perform(user_id: user_id, weight: weight)
    user = User.find(user_id)
    Order::Delivery.new(user, weight).setup
  end
end
