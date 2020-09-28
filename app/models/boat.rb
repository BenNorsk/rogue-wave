class Boat < ApplicationRecord
  belongs_to :user
  has_many :bookings, dependent: :destroy

  # this assumes that there is a 1:1 relationship between the boat and the address
  belongs_to :address, dependent: :destroy
end
