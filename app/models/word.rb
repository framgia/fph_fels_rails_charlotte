class Word < ApplicationRecord
  belongs_to :category
  has_many :choices, dependent: :destroy
  accepts_nested_attributes_for :choices
  validates :content, presence: true, uniqueness: true, length: { maximum: 50 }
  validates :choices, presence: true
  validate :at_least_one_is_checked

  private
    def at_least_one_is_checked
      size = choices.select {|a| a.correct == true}.count
      if size == 0 || size > 1
        return errors.add :base, "Must have one correct choice"
      end
    end
end
