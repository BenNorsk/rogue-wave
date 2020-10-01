require 'faker'
require 'betterlorem'
require 'date'

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

puts "---> Sucessfully created #{Boat.all.length} boats, allocated to #{User.all.length} users."



puts 'Generating 3 bookings per user.'
bookings = []
date_today = Date.new(2020, 10, 1)
users.each do |user|
  3.times do
    date_start = Date.new(date_today.year, date_today.month, (date_today.day + (14 * rand).to_i))
    date_end = Date.new(date_start.year, date_start.month, (date_start.day + (5 * rand).to_i))
    message = Faker::Quote.yoda
    status = %w(pending accepted cancelled).sample
    Booking.create( { start_date: date_start, end_date: date_end, user_id: user.id, boat_id: Boat.all.sample.id, message: message, status: status } )
  end
end

puts "---> Successfully created 3 bookings per user, 30 in total."

# create_table "bookings", force: :cascade do |t|
#     t.datetime "start_date"
#     t.datetime "end_date"
#     t.datetime "created_at", precision: 6, null: false
#     t.datetime "updated_at", precision: 6, null: false
#     t.bigint "user_id", null: false
#     t.bigint "boat_id", null: false
#     t.index ["boat_id"], name: "index_bookings_on_boat_id"
#     t.index ["user_id"], name: "index_bookings_on_user_id"
#   end





