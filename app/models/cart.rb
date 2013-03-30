class Cart
  attr_reader :session

  def initialize(session)
    @session = session
  end

  def items
    session.map do |id, quantity|
      CartItem.new(Product.find(id), quantity)
    end
  end

  def total
    items.map { |item| item.total }.inject(&:+)
  end

  def remove_item(remove_item_param)
    if id = remove_item_param[:product_id]
      session.delete(id)
    end
    session
  end

  def update(carts_param)
    if id = carts_param[:product_id]
      quantity = carts_param[:quantity]
      session[id] = quantity || (session[id].to_i + 1).to_s
    end
    session
  end

  def destroy
    session = {}
  end

  def count
    session.present? ? "(#{calculate_count})" : nil
  end

  def empty?
    items.empty?
  end

private
  def calculate_count
    session.values.map(&:to_i).reduce(&:+)
  end
end
