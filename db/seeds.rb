# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Product.destroy_all
Review.destroy_all
User.destroy_all

PASSWORD = "supersecret"

super_user = User.create(
    first_name: "Jon",
    last_name: "Snow",
    email: "js@winterfell.gov",
    password: "daenerystargaryen"
)

100.times do
    # print Faker::SiliconValley.character
    full_name = Faker::SiliconValley.character.split(" ")


    User.create(
        first_name: full_name[0],
        last_name: full_name[-1],
        email: Faker::SiliconValley.email,
        password: PASSWORD
    )
end

users = User.all

1000.times do

    p = Product.create(
    title: Faker::Cannabis.strain,
    description: Faker::Cannabis.health_benefit,
    price: rand(1_00)
    )

    if p.valid?
        rand(0..25).times do
            p.reviews << Review.new(
                body: Faker::GameOfThrones.quote,
                rating: rand(1..5),
                user: users.sample
            )
        end
    end
end

products = Product.all
reviews = Review.all

puts Cowsay.say("Generated #{products.count} invaluable products", :frogs)
puts Cowsay.say("Generated #{reviews.count} reviews", :sheep)
puts Cowsay.say("Generated #{users.count} users", :ghostbusters)
puts Cowsay.say("Generated #{super_user.email} and password: #{super_user.password}", :dragon)