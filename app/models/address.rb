class Address < ApplicationRecord
  # include PgSearch::Model
  # pg_search_scope :search_by_address, against: [:city, :country, :lat, :long]
  geocoded_by :full_address
  before_validation :geocode

  def full_address
    "#{street_address} - #{city}, #{country}"
  end
end
