class Admin::WordsController < ApplicationController
  before_action :admin_user

  def show
    @word = Word.find(params[:id])
    @category = Category.find_by_id(params[:category_id])
  end

  def new
    @category = Category.find_by_id(params[:category_id])
    @word = Word.new
    4.times { @word.choices.build }
  end

  def create
    @category = Category.find_by_id(params[:category_id])
    @word = @category.words.build(word_params)
    if @word.save
      flash[:success] = "Word successfully created!"
      redirect_to [:admin, @category]
    else
      render 'new'
    end
  end

  def edit
    @word = Word.find(params[:id])
    @category = Category.find_by_id(params[:category_id])
  end

  def update
    @word = Word.find(params[:id])
    @category = Category.find_by_id(params[:category_id])
    if @word.update_attributes(word_params)
      flash[:success] = "Word has been updated"
      redirect_to admin_category_word_url
    else
      render 'edit'
    end
  end

  private
    def word_params
      params.require(:word).permit(:content, choices_attributes: [:id, :content, :correct ])
    end
end