class Cart
  attr_reader :session

  def initialize(session)
    @session = session
  end

  def representation
    Hash[session.map { |id, quantity| [Product.find(id), quantity] }]
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

  def count
    session.present? ? "(#{calculate_count})" : nil
  end

private
  def calculate_count
    session.values.map(&:to_i).reduce(&:+)
  end
end
