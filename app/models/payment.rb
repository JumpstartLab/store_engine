class Payment
  attr_reader :token, :price, :email, :order

  def self.new_with_charge(params)
    payment = new(params)
    payment.charge
  end

  def initialize(params)
    @token = params[:token]
    @price = (params[:price] * 100).to_i
    @email = params[:email]
    @order = params[:order]
  end

  def charge
    begin
      charge = Stripe::Charge.create(:amount => price,
                                     :currency => "usd",
                                     :card => token,
                                     :description => email)
      order.status = 'paid'
      order.save
      charge
    rescue Stripe::CardError => e
      e.message
    end
  end
end
