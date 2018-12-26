class AnswersController < ApplicationController
  def new
    @lesson = Lesson.find_by_id(params[:lesson_id])
    @answer = Answer.new

    @lesson.category.words.each do |word|
      unless @lesson.answers.where(word: word).exists?
        @word = word
        @progress = @lesson.answers.length + 1
        break
      end
    end

    if @word.nil?
      @lesson.update_attribute(:result, @lesson.correct_answers.count)
      generate_activity
      redirect_to @lesson
    end
  end

  def create
    @lesson = Lesson.find_by_id(params[:lesson_id])
    @answer = @lesson.answers.build(answer_params)
    @answer.save

    redirect_to new_lesson_answer_url(@lesson)
  end

  private
    def answer_params
      params.require(:answer).permit(:word_id, :choice_id)
    end

    def generate_activity
      @lesson.create_activity(user: @lesson.user)
    end
end