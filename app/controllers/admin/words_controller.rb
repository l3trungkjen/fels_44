class Admin::WordsController < ApplicationController
  before_action :build_instance, only: [:new, :create]
  before_action :build_children, only: :new

  def index
    @words = Word.paginate page: params[:page], per_page: 10
  end

  def new
  end

  def create
    if @word.save
      flash[:message] = "Word was created successfully..."
    else
      flash[:message] = "Word was created successfully..."
    end
    redirect_to new_admin_word_path
  end

  def edit
    @word = Word.find params[:id]
  end

  def update
    @word = Word.find params[:id]
    if @word.update word_params
      flash[:message] = "Word was updated successfully..."
    else
      flash[:message] = " Word was updated failure..."
    end
    redirect_to edit_admin_word_path
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
      return {} unless params[:word]
      params.require(:word).permit(:category_id, :name, :mean, answers_attributes: [:id, :name, :correct, :_destroy])
    end

    def build_children
      1.times {@word.answers.build}
    end

    def build_instance
      @word = Word.new word_params
    end
end
