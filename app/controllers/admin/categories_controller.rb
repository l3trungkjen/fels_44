class Admin::CategoriesController < ApplicationController

  def index
    @categories = Category.paginate page: params[:page], per_page: 10
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new category_params
    if @category.save
      flash[:message] = "Category was created successfully..."
      redirect_to admin_categories_path
    else
      render :new
    end
  end

  def edit
    @category = Category.find params[:id]
  end

  def update
    @category = Category.find params[:id]
    if @category.update category_params
      flash[:message] = "Category was updated successfully..."
      redirect_to admin_categories_path
    else
      render :edit
    end
  end

  def destroy
    @category = Category.find params[:id]
    if @category.destroy
      flash[:message] = "Category was deleted successfully..."
    else
      flash[:message] = "Category was deleted failure..."
    end
    redirect_to admin_categories_path
  end

  private
  def category_params
    params.require(:category).permit(:name, :status)
  end

end
