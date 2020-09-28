class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :bookings, dependent: :destroy
  has_many :boats, dependent: :destroy

   # this assumes that there is a 1:1 relationship between the boat and the address
  belongs_to :address, dependent: :destroy

  # each user must have a first and last name (email and password verified by devise)
  validates :first_name, presence: true
  validates :last_name, presence: true
end
