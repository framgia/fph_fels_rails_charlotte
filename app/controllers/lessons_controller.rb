class LessonsController < ApplicationController
  def create
    @category = Category.find_by_id(params[:category_id])
    @lesson = Lesson.new(category_id: @category.id, user_id: current_user.id) #check how to properly pass parameters for this

    if @lesson.save
      redirect_to new_lesson_answer_url(@lesson)
    else
      flash[:danger] = "Lesson did not save"
      redirect_to categories_url
    end
  end

  def update_result
    @lesson.increment!(params[:result])
  end
end