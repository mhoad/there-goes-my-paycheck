class StaticPagesController < ApplicationController
  def index
    @products = Product.all.paginate(:page => params[:page],
                                            :per_page => 30)
    @categories = Category.all
  end

  def about
    
  end

  def submit
    
  end

  def privacy
    
  end

end
