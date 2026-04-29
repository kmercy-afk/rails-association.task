# ----- CLEAN DATABASE -----
OrderFood.destroy_all
Order.destroy_all
Food.destroy_all
Shop.destroy_all
Address.destroy_all
Customer.destroy_all

puts "Database cleaned!"

# ----- CUSTOMERS + POLYMORPHIC ADDRESSES -----
customer1 = Customer.create!(name: "Alice")
customer1.create_address!(
  street: "Nairobi Street 1",
  city: "Nairobi",
  addressable: customer1
)

customer2 = Customer.create!(name: "Brian")
customer2.create_address!(
  street: "Mombasa Road 22",
  city: "Mombasa",
  addressable: customer2
)

puts "Customers and addresses created!"

# ----- SHOPS -----
shop1 = Shop.create!(name: "Tokyo Bites")
shop2 = Shop.create!(name: "Beijing Express")
shop3 = Shop.create!(name: "Roma Kitchen")

puts "Shops created!"

# ----- FOODS (STI + Base Food) -----

# Japanese Food
sushi = JapaneseFood.create!(name: "Sushi", price: 850, shop: shop1)
ramen = JapaneseFood.create!(name: "Ramen", price: 650, shop: shop1)

# Chinese Food
dimsum = ChineseFood.create!(name: "Dim Sum", price: 500, shop: shop2)
noodles = ChineseFood.create!(name: "Chow Mein", price: 550, shop: shop2)

# Italian Food
pizza = ItalianFood.create!(name: "Pizza", price: 1200, shop: shop3)
pasta = ItalianFood.create!(name: "Spaghetti", price: 800, shop: shop3)

puts "Foods (including STI types) created!"

# ----- ORDER ADDRESSES -----
order_address1 = Address.create!(
  street: "Order Street 50",
  city: "Nairobi"
)

order_address2 = Address.create!(
  street: "Order Avenue 10",
  city: "Mombasa"
)

puts "Order addresses created!"

# ----- ORDERS -----
order1 = Order.create!(
  customer: customer1,
  address: order_address1
)

order2 = Order.create!(
  customer: customer2,
  address: order_address2
)

puts "Orders created!"

# ----- ORDER FOODS (JOIN TABLE) -----
OrderFood.create!(order: order1, food: sushi)
OrderFood.create!(order: order1, food: pizza)

OrderFood.create!(order: order2, food: noodles)
OrderFood.create!(order: order2, food: ramen)
OrderFood.create!(order: order2, food: pasta)

puts "OrderFood joins created!"

puts "🌱 Seeding complete!"
