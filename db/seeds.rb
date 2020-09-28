require 'faker'
require 'betterlorem'

puts 'Deleting all records'
Boat.destroy_all
puts 'done'

50.times do
  Boat.create(
    name: Faker::Name.unique.name,
    description: BetterLorem.p(1, true),
    price_per_day: Faker::Number.within(range: 1000..2000),
    user_id: Faker::Number.within(range: 1..99).uniq,
    address_id: Faker::Number.within(range: 100..200).uniq
  )
end

p Boat.all
