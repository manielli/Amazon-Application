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
Favourite.destroy_all
Like.destroy_all
Tag.destroy_all
Tagging.destroy_all

PASSWORD = "supersecret"

super_user = User.create(
    first_name: "Jon",
    last_name: "Snow",
    email: "js@winterfell.gov",
    password: "daenerystargaryen",
    admin: true
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

10.times do
    Tag.create(
        name: Faker::Cannabis.medical_use
    )
end

tags = Tag.all

1000.times do

    p = Product.create(
    title: Faker::Cannabis.strain,
    description: Faker::Cannabis.health_benefit,
    price: rand(1_00),
    user: users.sample
    )

    if p.valid?

        p.favouriters = users.shuffle.slice(0, rand(users.count))
        p.tags = tags.shuffle.slice(0, rand(tags.count/2))

        
        rand(0..25).times do
            p.reviews << Review.new(
                body: Faker::GameOfThrones.quote,
                rating: rand(1..5),
                user: users.sample
            )
            rand(0..10).times do
                p.reviews.last.likes << Like.new(
                    user: users.sample
                )
            end
            rand(0..10).times do
                p.reviews.last.votes << Vote.new(
                    status: [true, false].sample,
                    user: users.sample
                )
            end
        end
    end
end

products = Product.all
reviews = Review.all
favourites = Favourite.all
likes = Like.all
votes = Vote.all

puts Cowsay.say("Generated #{products.count} invaluable products", :frogs)
puts Cowsay.say("Generated #{reviews.count} reviews", :sheep)
puts Cowsay.say("Generated #{users.count} users", :ghostbusters)
puts Cowsay.say("Generated #{super_user.email} and password: #{super_user.password}", :dragon)
puts Cowsay.say("Made #{favourites.count} products favourites", :koala)
puts Cowsay.say("Generated #{tags.count} tags", :cheese)
puts Cowsay.say("Generated #{likes.count} likes on different reviews", :koala)
puts Cowsay.say("Generated #{votes.count} random votes on many review", :frogs)