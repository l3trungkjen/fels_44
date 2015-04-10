class Admin::WordsController < ApplicationController
  before_action :build_children, only: :new

  def index
    @words = Word.paginate page: params[:page], per_page: 10
  end

  def new
    @word = Word.new word_params
  end

  def create
    @word = Word.new word_params
    if @word.save
      flash[:message] = "Word was created successfully..."
      redirect_to admin_words_path
    else
      render :new
    end
  end

  def edit
    @word = Word.find params[:id]
  end

  def update
    @word = Word.find params[:id]
    if @word.update word_params
      flash[:message] = "Word was updated successfully..."
      redirect_to admin_words_path
    else
      render :edit
    end
  end

  def destroy
    @word = Word.find params[:id]
    if @word.destroy
      flash[:message] = "Word was deleted successfully..."
    else
      flash[:message] = "Word was deleted failure..."
    end
    redirect_to admin_words_path
  end

  private
  def word_params
    params.require(:word).permit(:category_id, :name, :mean,
                                  answers_attributes:
                                  [
                                    :id, :name, :correct, :_destroy
                                  ]
                                )
  end

  def build_children
    1.times {@word.answers.build}
  end
end
