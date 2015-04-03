class WordsController < ApplicationController

  def index
    @words = Word.all
  end

  def new
    @word = Word.new
  end

  def create
    @word = Word.new(word_params)
    if @word.save
      flash[:message] = 'Word was created successfully...'
    else
      flash[:message] = 'Word was created failure...'
    end
    redirect_to new_word_path
  end

  def edit
    @word = Word.find(params[:id])
  end

  def update
    @word = Word.find(params[:id])
    if @word.update(word_params)
      flash[:message] = 'Word was updated successfully...'
    else
      flash[:message] = ' Word was updated failure...'
    end
    redirect_to edit_word_path
  end

  def destroy
    @word = Word.find(params[:id])
    if @word.destroy
      flash[:message] = 'Word was deleted successfully...'
    else
      flash[:message] = 'Word was deleted failure...'
    end
    redirect_to words_path
  end

  private
    def word_params
      params.require(:word).permit(:category_id, :name, :mean)
    end

end
