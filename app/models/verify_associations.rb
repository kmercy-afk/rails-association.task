puts "\n=== VERIFYING ASSOCIATIONS ===\n\n"

def pass(msg)
  puts "✅ #{msg}"
end

def fail(msg)
  puts "❌ #{msg}"
end

begin
  # Load sample records
  customer  = Customer.first
  order     = Order.first
  address   = Address.first
  shop      = Shop.first
  food      = Food.first
  jap       = JapaneseFood.first
  chi       = ChineseFood.first
  ita       = ItalianFood.first

  # -----------------------------
  # CUSTOMER CHECKS
  # -----------------------------
  if customer&.address&.addressable == customer
    pass "Customer ↔ Address polymorphic OK"
  else
    fail "Customer polymorphic address NOT correctly linked"
  end

  if customer.orders.any?
    pass "Customer has_many :orders OK"
  else
    fail "Customer has_many :orders FAILED (no orders found)"
  end

  # -----------------------------
  # ORDER CHECKS
  # -----------------------------
  if order&.customer
    pass "Order belongs_to :customer OK"
  else
    fail "Order belongs_to :customer FAILED"
  end

  if order&.address
    pass "Order belongs_to :address OK"
  else
    fail "Order belongs_to :address FAILED"
  end

  if order.foods.any?
    pass "Order has_many :foods through :order_foods OK"
  else
    fail "Order has_many :foods FAILED"
  end

  # -----------------------------
  # SHOP CHECKS
  # -----------------------------
  if shop&.foods&.any?
    pass "Shop has_many :foods OK"
  else
    fail "Shop has_many :foods FAILED"
  end

  # -----------------------------
  # FOOD CHECKS
  # -----------------------------
  if food&.shop
    pass "Food belongs_to :shop OK"
  else
    fail "Food belongs_to :shop FAILED"
  end

  if food&.orders
    pass "Food has_many :orders through order_foods OK"
  else
    fail "Food has_many :orders FAILED"
  end

  # -----------------------------
  # ORDERFOOD CHECKS
  # -----------------------------
  of = OrderFood.first
  if of&.order && of&.food
    pass "OrderFood joins Order ↔ Food OK"
  else
    fail "OrderFood join FAILED"
  end

  # -----------------------------
  # STI CHECKS
  # -----------------------------
  if jap && jap.type == "JapaneseFood"
    pass "STI JapaneseFood OK"
  else
    fail "STI JapaneseFood FAILED"
  end

  if chi && chi.type == "ChineseFood"
    pass "STI ChineseFood OK"
  else
    fail "STI ChineseFood FAILED"
  end

  if ita && ita.type == "ItalianFood"
    pass "STI ItalianFood OK"
  else
    fail "STI ItalianFood FAILED"
  end

rescue => e
  puts "\n❌ ERROR DURING VERIFICATION"
  puts e.message
  puts e.backtrace.first(3)
end

puts "\n=== DONE ===\n"
