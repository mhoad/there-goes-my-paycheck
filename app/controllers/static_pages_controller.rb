class StaticPagesController < ApplicationController
  def index
    @products = Product.all.paginate(:page => params[:page],
                                            :per_page => 30)
    @categories = Category.all
    set_meta_tags :title => 'Unique Gifts and Products',
                  :description => 'Write some awesome description here'

    #Set the appropriate pagination values for search engines if required
    set_meta_tags :next => @products.next_page if @products.next_page
    set_meta_tags :prev => @products.previous_page if @products.previous_page
  end

  def about
    set_meta_tags :title => 'About Us',
                  :description => 'Write some awesome description here'
  end

  def submit
    set_meta_tags :title => 'Submit a Product',
                  :description => 'Write some awesome description here'
  end

  def privacy
    set_meta_tags :title => 'Privacy Policy',
                  :description => 'Write some awesome description here'
  end

  def facebook_channel
    render layout: false
    expires_in 1.year, :public => true
  end

end
