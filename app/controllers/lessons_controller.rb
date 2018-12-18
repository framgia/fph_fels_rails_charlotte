class LessonsController < ApplicationController
  def create
    @category = Category.find_by_id(params[:category_id])
    @lesson = Lesson.new(category_id: @category.id, user_id: current_user.id)

    if @lesson.save && @lesson.category.words.any?
      redirect_to new_lesson_answer_url(@lesson)
    else
      flash[:danger] = "There are no words in this category yet"
      redirect_to categories_url
    end
  end

  def show
    @lesson = Lesson.find_by_id(params[:id])
    @result = @lesson.correct_answers.count
  end
end