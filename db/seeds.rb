require 'faker'
require 'betterlorem'

# Remove all current entries in the DB
puts '---> Destroying all DB entries"'
User.destroy_all
Address.destroy_all
Boat.destroy_all


puts '---> Generating 10 fake users"'
users = []
10.times do
  users << User.create(
    first_name: Faker::Name.first_name  ,
    last_name: Faker::Name.last_name ,
    email: Faker::Internet.email,
    password: 'topsecret')
  end

# Functions to generate some random GPS coordinates in the oslo fjord
# lat 59.74 -> 59.94
# long 10.46 -> 10.81
# Generate a random latitude in the Oslo area
def lat_range (min, max)
  lat = rand(0..(max - min)) + min
  lat
end
# Generate a random longditude in the Oslo area
def long_range (min, max)
  long = rand(0..(max - min)) + min
  long
end

puts '---> Generating 10 fake boats"'
i = 0
while (i < 10)
  i.even? ? j = 2 : j = 1
  j.times do
    new_address = Address.create(
      city: "Oslo",
      street_address: Faker::Address.street_address,
      country: "Norway",
      lat: lat_range(59.74, 59.94),
      long: long_range(10.46, 10.81)
    )

    Boat.create(
      name: Faker::Name.name,
      description: BetterLorem.p(1, true),
      price_per_day: Faker::Number.within(range: 500..2000),
      user_id: users[i].id,
      address_id: new_address.id
    )
  end
  i += 1
end

puts '---> Generating 30 bookings'
i = 0
all_users = User.all
while (i < 30)
  user = all_users(i / 3)
  booking = Booking.create(
    start_date: Date.at(rand * 0.9 +)
    )


  create_table "bookings", force: :cascade do |t|
    t.datetime "start_date"
    t.datetime "end_date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "user_id", null: false
    t.bigint "boat_id", null: false
    t.index ["boat_id"], name: "index_bookings_on_boat_id"
    t.index ["user_id"], name: "index_bookings_on_user_id"
  end



puts "---> Sucessfully created #{Boat.all.length} boats, allocated to #{User.all.length} users."
