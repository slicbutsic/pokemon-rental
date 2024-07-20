class Pokemon < ApplicationRecord
  belongs_to :user
  has_many :reviews, dependent: :destroy
  has_many_attached :photos
  validates :name, presence: true
  validates :address, presence: true
  validates :overview, presence: true
  validates :price, presence: true
  validates :photos, presence: true

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
  has_many :bookings

  include PgSearch::Model
  pg_search_scope :search_pokemon,
  against: [ :name, :overview, :address ],
  associated_against: {
    user: [ :email ]
  },
  using: {
    tsearch: { prefix: true }
  }

end
