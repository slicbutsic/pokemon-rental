class Pokemon < ApplicationRecord
  belongs_to :user
  has_many_attached :photos
  validates :address, presence: true
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

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
