class Review < ApplicationRecord
  belongs_to :pokemon
  belongs_to :user

  validates :content, presence: true
end
