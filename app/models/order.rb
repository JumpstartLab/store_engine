class Order < ActiveRecord::Base
  attr_accessible :status, :total_price
  attr_accessor :stripe_card_token
  attr_accessible :stripe_card_token

  validates :status, :inclusion => { :in => %w(pending cancelled shipped paid)}

  has_many :order_items
  has_many :products, through: :order_items
  belongs_to :user
  
  def total_price
    order_items.inject(0) do |result, item|
      result += item.unit_price * item.quantity
    end
  end

  def total_price_in_cents
    total_price * 100
  end

  def save_with_payment
    if valid?
      customer = Stripe::Customer.create(description: user.email,
      card: stripe_card_token)

      Stripe::Charge.create(
        :amount => total_price_in_cents.to_i,
        :currency => "usd",
        :customer => customer.id,
        :description => "order##{id}" )

      # self.stripe_customer_token = customer.id
      save!
    end
    rescue Stripe::InvalidRequestError => e
  logger.error "Stripe error while creating customer: #{e.message}"
  errors.add :base, "There was a problem with your credit card."
  end

  def populate_from(cart)
  	Cart.find_by_id(cart)
  end

  def add_order_items_from(cart)
  	# raise cart.items.inspect
  	cart.cart_items.each do |item|
  		oi = OrderItem.new(	quantity: item.quantity,
  							unit_price: item.individual_price,
  							order_id: self.id)# take each cart_item and convert it to an order_item
  		oi.product = item.product
  		oi.save
  	end
  end
end

# order_items = OrderItem.new( 
#   quantity: 10, 
#   unit_price: 50, 
#   product_id: products.first.id,
#   order_id: orders.first.id )

# create_table "order_items", :force => true do |t|
#     t.integer  "product_id"
#     t.integer  "order_id"
#     t.integer  "quantity"
#     t.decimal  "unit_price", :precision => 12, :scale => 2
#     t.datetime "created_at",                                :null => false
#     t.datetime "updated_at",                                :null => false
#   end