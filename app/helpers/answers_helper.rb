module AnswersHelper
  def total(user)
    Answer.where(lesson: Lesson.where(user_id: user.id).where.not(result: nil)).count
  end
end