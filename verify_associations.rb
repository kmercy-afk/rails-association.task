# verify_associations.rb
puts "=== VERIFYING ASSOCIATIONS ==="

success = true

# 1. Customer has one Address
Customer.all.each do |customer|
  if customer.address
    puts "✅ Customer #{customer.id} has an address."
  else
    puts "❌ Customer #{customer.id} does NOT have an address."
    success = false
  end
end

# 2. Order belongs to Customer and Address
Order.all.each do |order|
  unless order.customer
    puts "❌ Order #{order.id} does not belong to a Customer."
    success = false
  else
    puts "✅ Order #{order.id} belongs to Customer #{order.customer.id}."
  end

  unless order.address
    puts "❌ Order #{order.id} does not have an Address."
    success = false
  else
    puts "✅ Order #{order.id} has an Address #{order.address.id}."
  end
end

# 3. Food belongs to Shop
Food.all.each do |food|
  if food.shop
    puts "✅ Food #{food.name} (#{food.type || 'Food'}) belongs to Shop #{food.shop.id}."
  else
    puts "❌ Food #{food.name} (#{food.type || 'Food'}) does NOT belong to any Shop."
    success = false
  end
end

# 4. OrderFood associations
OrderFood.all.each do |of|
  unless of.order && of.food
    puts "❌ OrderFood #{of.id} is missing order or food."
    success = false
  else
    puts "✅ OrderFood #{of.id} links Order #{of.order.id} with Food #{of.food.name}."
  end
end

# 5. STI check: JapaneseFood, ChineseFood, ItalianFood
{JapaneseFood: JapaneseFood, ChineseFood: ChineseFood, ItalianFood: ItalianFood}.each do |name, klass|
  klass.all.each do |f|
    if f.orders.any?
      puts "✅ #{name} #{f.name} has orders: #{f.orders.map(&:id)}"
    else
      puts "✅ #{name} #{f.name} exists but has no orders yet (still valid)."
    end
  end
end

puts "\n=== ASSOCIATION VERIFICATION COMPLETE ==="
puts success ? "All associations seem correctly set up ✅" : "Some associations are missing ❌"
