module Order
  class Delivery
    def initialize(user, weight)
      @user = user,
      @address = user.address,
      @weight = weight
    end

    def setup
      delivery_provider_result = setup_delivery_in_provider

      if delivery_provider_result[:result] == 'succeed'
        delivery = create_delivery
        notify_user(delivery)
      end
    end

    private

    attr_reader :user, :address, :weight

    def setup_delivery_in_provider
      delivery_provider.setup_delivery(address: address, person: person, weight: weight)
    end

    def delivery_provider
      Sdek
    end

    def notify_user(delivery)
      OrderMailer.delivery_email(delivery).deliver_later
    end

    def create_delivery
      Delivery.create(address: address, person: person, weight: weight)
    end
  end
end
