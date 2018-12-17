class Word < ApplicationRecord
  belongs_to :category
  has_many :answers
  has_many :choices, dependent: :destroy
  accepts_nested_attributes_for :choices
  validates :content, presence: true, uniqueness: true, length: { maximum: 50 }
  validates :choices, presence: true
  validate :at_least_one_is_checked
  validate :unique_choices

  private
    def at_least_one_is_checked
      if choices.select {|choice| choice.correct == true}.count != 1
        return errors.add :base, "Must have one correct choice"
      end
    end

    def unique_choices
      if choices.uniq { |choice| choice.content }.count < choices.length
        return errors.add :base, "Choices must be unique"
      end
    end
end