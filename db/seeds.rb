# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Product.destroy_all

1000.times do

    Product.create(
    title: Faker::Cannabis.strain,
    description: Faker::Cannabis.health_benefit,
    price: rand(1_000)
    )
end

product = Product.all
puts Cowsay.say("Generated #{product.count} invaluable products", :frogs)