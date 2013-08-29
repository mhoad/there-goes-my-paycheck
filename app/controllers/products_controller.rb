class ProductsController < ApplicationController
  before_action :set_category
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  def new
    @product = @category.products.new
  end

  def create
    @product = @category.products.new(product_params)
    if @product.save
      flash[:success] = "Product successfully created"
      redirect_to [@category, @product]
    else
      render 'new'
    end
  end

  def show

  end

  private
    # Using a private method to encapsulate the permissible parameters is just a good pattern
    # since you'll be able to reuse the same permit list between create and update. Also, you
    # can specialize this method with per-user checking of permissible attributes.
    def product_params
      params.require(:product).permit(:name, :description, :url, :category_id)
    end

    def set_category
      @category = Category.find(params[:category_id])
    end

    def set_product
      @product = @category.products.find(params[:id])
    end
end
