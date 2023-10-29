class PaymentsController < ApplicationController
  before_action :find_product, only: :create

  def create
    purchase_result = Billing::Purchase.new(user: current_user, product: @product).make_purchase

    if purchase_result.success?
      redirect_to :successful_payment_path
    else
      redirect_to :failed_payment_path, note: purchase_result.error_message
    end
  end

  private

  def find_product
    @product = Product.find(params[:product_id])
  end
end
