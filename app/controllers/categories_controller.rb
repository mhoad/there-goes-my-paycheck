class CategoriesController < ApplicationController
  include ApplicationHelper
  
  before_action :require_login, except:[:show, :index]
  before_action :set_category, only: [:show, :edit, :update, :destroy]

  def show
    @categories = @category.subcategories # Grab all sub-categories
    @products = @category.products.paginate(:page => params[:page],
                                            :per_page => 30)

  end

  def new
    @category = Category.new
    @category.parent = Category.find(params[:id]) unless params[:id].nil?
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:success] = "Category sucessfully created"
      redirect_to @category
    else
      flash[:alert] = "Category not created"
      render 'new'
    end
  end

  def edit
  end

  def update
    @category.update_attributes(category_params)
    if @category.save
      flash[:success] = "Category sucessfully updated"
      redirect_to @category
    else
      flash[:alert] = "Category not updated"
      render 'edit'
    end
  end

  def destroy
    @category.destroy
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

    def set_category
      #@category = Category.find(params[:id])
      @category = Category.friendly.find(params[:id])
    end
end
