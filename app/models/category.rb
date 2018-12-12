class Category < ApplicationRecord
  validates :title, presence: true, uniqueness: true, length: { maximum: 50 }
  has_many :words, dependent: :destroy
end