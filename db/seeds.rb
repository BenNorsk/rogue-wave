require 'faker'
require 'betterlorem'
require 'date'

# Remove all current entries in the DB
puts '---> Destroying all DB entries'
User.destroy_all
Address.destroy_all
Boat.destroy_all

user_number = 10
booking_number = 3


puts "---> Generating #{user_number} fake users"
users = []
user_number.times do
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

puts "---> Generating #{user_number} fake boats"


boat_models = %w[Fishing Dinghy Deck Bowrider Catemaran Cuddy Trawler Cabin Yacht Jet Banana Pontoon Life]

i = 0
while (i < user_number)
  i.even? ? j = 2 : j = 1
  j.times do
    new_address = Address.create(
      city: "Oslo",
      street_address: Faker::Address.street_address,
      country: "Norway",
      lat: lat_range(59.74, 59.94),
      long: long_range(10.46, 10.81)
    )

    boat = Boat.create(
      name: "#{boat_models.sample} Boat #{Faker::Vehicle.fuel_type}",
      description: "#{Faker::Marketing.buzzwords}, #{Faker::Marketing.buzzwords}, #{Faker::Marketing.buzzwords}, #{Faker::Marketing.buzzwords}",
      price_per_day: Faker::Number.within(range: 500..1000),
      user_id: users[i].id,
      address_id: new_address.id
    )

    images_url = []
    k = 1
    3.times do
      images_url << 'https://source.unsplash.com/400x300/?' + "boat/#{k}"
      k += 1
    end

    images_url.each_with_index do |image, i|
      file = URI.open(image)
      boat.photos.attach(io: file, filename: i.to_s, content_type: 'image/png')
    end

    puts "Boat #{boat.name} created with 3 attached pictures"
  end
  i += 1
end

puts "---> Sucessfully created #{Boat.all.length} boats, allocated to #{User.all.length} users."


puts "---> Generating #{booking_number} bookings per user."
bookings = []
date_today = Date.new(2020, 10, 1)
users.each do |user|
  booking_number.times do
    date_start = Date.new(date_today.year, date_today.month, (date_today.day + (14 * rand).to_i))
    date_end = Date.new(date_start.year, date_start.month, (date_start.day + (5 * rand).to_i))
    message = Faker::Quote.yoda
    status = %w(pending accepted cancelled).sample
    Booking.create( { start_date: date_start, end_date: date_end, user_id: user.id, boat_id: Boat.all.sample.id, message: message, status: status } )
  end
end

puts "---> Successfully created #{booking_number} bookings per user, #{booking_number * user_number} in total."

