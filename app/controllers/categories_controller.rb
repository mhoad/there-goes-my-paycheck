class CategoriesController < ApplicationController
  before_action :require_login, except:[:show, :index]

  def show
    @category = Category.find(params[:id])
    @categories = @category.subcategories # Grab all sub-categories
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
      render 'new'
    end
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
    @category.update_attributes(category_params)
    if @category.save
      flash[:success] = "Product sucessfully updated"
      redirect_to @category
    else
      render 'edit'
    end
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

    def require_login
      unless user_signed_in? && current_user.admin?
        flash[:error] = "You must be logged in to access this section"
        redirect_to new_user_session_path # halts request cycle
      end
    end

    def top_categories
      Category.where(:parent_id => nil) 
    end

end
