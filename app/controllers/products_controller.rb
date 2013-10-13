class ProductsController < ApplicationController
  include ApplicationHelper
  include ProductsHelper

  before_action :set_category
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  before_action :require_login, except:[:show]


  def new
    @product = @category.products.build
  end

  def create
    @product = @category.products.build(product_params)
    #@product = @category.products.new(product_params)
    if @product.save
      flash[:success] = "Product successfully created"
      redirect_to [@category, @product]
    else
      flash[:alert] = "Product not created"
      render 'new'
    end
  end

  def show
    metadata(@product)
  end

  def edit
  end

  def destroy
    @product.destroy
    flash[:notice] = 'Product sucessfully deleted'
    redirect_to categories_path
  end

  def update
    if @product.update(product_params)
      flash[:notice] = 'Product successfully updated'
      redirect_to [@category, @product]
    else
      flash[:alert] = 'Product not updated'
      render 'edit'
    end
  end

  private
    # Using a private method to encapsulate the permissible parameters is just a good pattern
    # since you'll be able to reuse the same permit list between create and update. Also, you
    # can specialize this method with per-user checking of permissible attributes.
    def product_params
      params.require(:product).permit(:name, :description, :url, :category_id, :picture, 
                                      :price, :social_image)
    end

    def set_category
      @category = Category.friendly.find(params[:category_id])
    end

    def set_product
      @product = @category.products.friendly.find(params[:id])
    end
end
