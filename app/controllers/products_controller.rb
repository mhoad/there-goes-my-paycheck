class ProductsController < ApplicationController
  include ApplicationHelper

  before_action :set_category
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  before_action :require_login, except:[:show]


  def new
    @product = @category.products.build
  end

  def create
    @product = @category.products.build(product_params)
    if @product.save
      flash[:success] = "Product successfully created"
      redirect_to [@category, @product]
    else
      flash[:alert] = "Product not created"
      render 'new'
    end
  end

  def show
  end

  def edit
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
      params.require(:product).permit(:name, :description, :url, :category_id, :picture, :price)
    end

    def set_category
      #2@category = Category.find(params[:category_id])
      @category = Category.friendly.find(params[:category_id])
    end

    def set_product
      @product = @category.products.friendly.find(params[:id])
    end
end
