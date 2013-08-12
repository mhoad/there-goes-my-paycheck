class CategoriesController < ApplicationController
  def index
    @categories = Category.find(:all, :conditions => {:parent_id => nil } )
  end

  def show
    # Find the category belonging to the given id
    @category = Category.find(params[:id])
    # Grab all sub-categories
    @categories = @category.subcategories
  end

  def new
    @category = Category.new
    @category.parent = Category.find(params[:id]) unless params[:id].nil?
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:success] = "Product sucessfully added"
      redirect_to @category
    else
      render 'new'
    end
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
    @category.update_attributes!(category_params)
    redirect_to @category
  end

  def destroy
    @category = Category.find(params[:id]).destroy
    flash[:success] = "Category successfully deleted"
    redirect_to categories_path
  end

  private
    # Using a private method to encapsulate the permissible parameters is just a good pattern
    # since you'll be able to reuse the same permit list between create and update. Also, you
    # can specialize this method with per-user checking of permissible attributes.
    def category_params
      params.require(:category).permit(:name, :description, :parent_id)
    end

end
