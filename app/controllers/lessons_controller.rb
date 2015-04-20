class LessonsController < ApplicationController

  def new
    @lesson = Lesson.new
    @category = Category.find params[:category_id]
    @words = @category.words.random_with_number 20
    @words.each{|word| @lesson.lesson_words.build word: word}
  end

  def create
    @category = Category.find params[:category_id]
    @lesson = @category.lessons.build lesson_params
    @lesson.user = current_user
    if @lesson.save
      flash[:message] = "Lesson was created successfully..."
    else
      flash[:message] = "Lesson was created failure..."
    end
    redirect_to [@category, @lesson]
  end

  def show
    @lesson = Lesson.find params[:id]
    @lesson_words = @lesson.lesson_words
  end

  private
  def lesson_params
    params.require(:lesson).permit :user_id, :category_id, :result,
      lesson_words_attributes: [:id, :word_id, :answer_id]
  end
end
