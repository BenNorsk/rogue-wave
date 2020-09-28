require 'faker'
require 'betterlorem'

puts 'Deleting all records'

puts 'done'

Address.create(city: 'oslo')
  address = Address.last.id

User.create(first_name: 'Ben', last_name: 'Reddik', email: 'ben@me.com', password: 'topsecret', address_id: address)
  user = User.last.id

50.times do
  Boat.create(
    name: Faker::Name.name,
    description: BetterLorem.p(1, true),
    price_per_day: Faker::Number.within(range: 1000..2000),
    user_id: user,
    address_id: address
  )
end

p Boat.all
