class Pokemon < ApplicationRecord
  belongs_to :user
  has_many_attached :photos

  include PgSearch::Model
  pg_search_scope :search_pokemon,
  against: [ :name, :overview ],
  associated_against: {
    user: [ :email ]
  },
  using: {
    tsearch: { prefix: true }
  }

end
