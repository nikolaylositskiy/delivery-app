module Billing
  class Purchase
    def initialize(product)
      @product = product
    end

    def make_purchase(user)
      payment_result = proccess_payment(user)
      if payment_result.success?
        product_access = grant_access_to_user(user: user)
        notify_user(product_access)
      end

      payment_result
    end

    private

    attr_reader :product

    def proccess_payment(user)
      payment_gateway.proccess(
        user_uid: user.cloud_payments_uid,
        amount_cents: product.amount_cents,
        currency: 'RUB'
      )
    end

    def grant_access_to_user(user)
      ProductAccess.create(user: user, product: product)
    end

    def notify_user(product_access)
      OrderMailer.product_access_email(product_access).deliver_later
    end

    def payment_gateway
      CloudPayment
    end
  end
end
