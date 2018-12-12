class Admin::WordsController < ApplicationController
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
      redirect_to admin_categories_url
    else
      render 'new'
    end
  end

  private
    def word_params
      params.require(:word).permit(:content, :category_id, choices_attributes: [ :content, :word_id, :correct ])
    end
end