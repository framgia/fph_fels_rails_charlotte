class Lesson < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_many :answers, dependent: :destroy
  has_one :activity, as: :action, dependent: :destroy

  def correct_answers
    self.answers.joins(:choice).where(choices: {correct: true})
  end
end