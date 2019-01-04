class LessonsController < ApplicationController
  def index
    @user = User.find(params[:id])
    @lessons = @user.lessons.paginate(page: params[:page], per_page: 3)
  end

  def create
    @category = Category.find_by_id(params[:category_id])
    @lesson = @category.lessons.build(user: current_user)

    if @category.words.any?
      @lesson.save
      redirect_to new_lesson_answer_url(@lesson)
    else
      flash[:danger] = "There are no words in this category yet"
      redirect_to categories_url
    end
  end

  def restart
    @lesson = Lesson.find(params[:id])
    @lesson.answers.destroy_all

    redirect_to new_lesson_answer_url(@lesson)
  end

  def show
    @lesson = Lesson.find(params[:id])
  end
end