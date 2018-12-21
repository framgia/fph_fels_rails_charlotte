class LessonsController < ApplicationController
  def index
    @user = User.find(params[:id])
    @lessons = @user.lessons.paginate(page: params[:page], per_page: 3)
  end

  def create
    @category = Category.find_by_id(params[:category_id])
    @lesson = Lesson.new(category_id: @category.id, user_id: current_user.id)

    if @category.words.any?
      @lesson.save
      create_activity
      redirect_to new_lesson_answer_url(@lesson)
    else
      flash[:danger] = "There are no words in this category yet"
      redirect_to categories_url
    end
  end

  def show
    @lesson = Lesson.find(params[:id])
    @result = @lesson.correct_answers.count
  end

  private
    def create_activity
      @activity = Activity.new(action: @lesson, user_id: current_user.id)
      @activity.save
    end
end