class Cart
  TAX_RATE = 0.125
  TAX_RATE_PERCENT = TAX_RATE * 100.0

  def initialize
    @cart = [] 
  end

  def add(product:, amount: 1)
    amount.times do 
      cart << product
    end
  end

  def size
    cart.size
  end

  def items_size_from(product:)
    cart
      .select { |item| item.name == product.name }
      .size
  end

  def remove_item(product:, amount: 1)
    indexes_to_remove = []

    cart.each.with_index do |item, index|
       indexes_to_remove << index if item.name == product.name
    end

    return cart.delete_at(indexes_to_remove.last) if amount == 1

    removed = 0

    while removed < amount
      cart.delete_at(indexes_to_remove.pop)
      removed += 1
    end
  end

  def total_price(tax: false)
    total =
      cart
        .reduce(0) { |sum, product| sum += (product.price / 100.0)  }
        .round(2)

    return total unless tax

    total + sale_tax
  end

  def sale_tax
    ((total_price * (TAX_RATE_PERCENT)) / 100.0).round(2)
  end

  private

  attr_reader :cart
end
