class StaticPagesController < ApplicationController
  def index
    @products = Product.all.paginate(:page => params[:page],
                                            :per_page => 15)
    @categories = Category.all
    set_meta_tags :title => 'Unique Gifts and Products',
                  :description => 'We spend hours every day trawling the internet for the most
                                  ridiculous, absurd, and amazing gifts and products. Check them all out here.'

    #Set the appropriate pagination values for search engines if required
    set_meta_tags :next => "#{canonical_url}{@products.next_page}" if @products.next_page
    set_meta_tags :prev => "#{canonical_url}{@products.previous_page}" if @products.previous_page
  end

  def about
    set_meta_tags :title => 'About Us',
                  :description => 'This page is for all you creepy stalker types who want to know
                                   a bit more about the people behind the site.',
                  :noindex => true
  end

  def submit
    set_meta_tags :title => 'Submit a Product',
                  :description => 'Get your product featured in front of thousands of people. 
                                  If you have something cool to share let us know here.',
                  :noindex => true
  end

  def privacy
    set_meta_tags :title => 'Privacy Policy',
                  :description => 'Show the world just how few fucks you give by spending your spare time
                                   reading a companies online privacy policy. ',
                  :noindex => true
  end

  def facebook_channel
    render layout: false
    expires_in 1.year, :public => true
  end

end
