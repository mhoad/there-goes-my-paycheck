class ProductsController < ApplicationController
  def new
    @category = Category.find(params[:category_id])
    @product = @category.products.new
  end

  def create
    @category = Category.find(params[:category_id])
    @product = @category.products.new(product_params)
    if @product.save
      flash[:success] = "Product successfully created"
      redirect_to category_product_path(:id => @product.id)
    else
      render 'new'
    end
  end

  def show
    @product = Product.find(params[:id])
  end

  private
    # Using a private method to encapsulate the permissible parameters is just a good pattern
    # since you'll be able to reuse the same permit list between create and update. Also, you
    # can specialize this method with per-user checking of permissible attributes.
    def product_params
      params.require(:product).permit(:name, :description, :url, :category_id)
    end
end
