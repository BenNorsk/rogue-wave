class Boat < ApplicationRecord
  # include PgSearch::Model
  # pg_search_scope :search_by_boat, against: [:description, :name, :price_per_day]
  belongs_to :user
  has_many :bookings, dependent: :destroy

  # this assumes that there is a 1:1 relationship between the boat and the address
  belongs_to :address, dependent: :destroy

  # Boat will have many attached photos
  has_many_attached :photos

  include PgSearch::Model
  pg_search_scope :global_search, against: [:name],
    associated_against: {
      address: [:city, :country, :lat, :long, :street_address]
    }, using: {
    tsearch: { prefix: true }
  }
end
