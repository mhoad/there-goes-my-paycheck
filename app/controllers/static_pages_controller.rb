class StaticPagesController < ApplicationController
  def index
    @products = Product.all
    @categories = Category.all
  end

  def about
    
  end

  def submit
    
  end

  def privacy
    
  end

end
