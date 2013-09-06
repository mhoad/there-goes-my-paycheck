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

  def facebook_channel
    render layout: false
    expires_in 1.year, :public => true
  end

end
