module AnswersHelper
  def total(user)
    Answer.where(lesson_id: Lesson.where(user_id: user.id)).count
  end
end