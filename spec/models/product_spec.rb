# == Schema Information
#
# Table name: products
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :text
#  url         :text
#  created_at  :datetime
#  updated_at  :datetime
#  category_id :integer
#

require 'spec_helper'

describe Product do
  
  before(:each) do
    @attr = {
      :name => "Sample Product",
      :description => "Bacon ipsum dolor sit amet flank pork brisket, 
      capicola jowl spare ribs tongue pastrami. Pork chop chuck 
      biltong meatloaf tail capicola ham filet mignon sirloin tongue 
      swine short loin. Pork loin shankle short ribs jowl. 
      Jowl tenderloin venison filet mignon ham ham hock.",
      :url => "http://www.sampleproduct.com/",
    }
  end

  it "should create a new instance given a valid attribute" do
    Product.create!(@attr).should be_valid
  end

  it "should require a product name" do
    no_name_product = Product.new(@attr.merge(:name => ""))
    no_name_product.should_not be_valid
  end

  it "should require a description of at least 30 words" do
    short_description_product = Product.new(@attr.merge(:description => "bacon"))
    short_description_product.should_not be_valid
  end

  it "should accept a valid product URL" do
    valid_urls = ["http://www.example.com/",
                  "http://www.example.com.au",
                  "http://www.example.co.jp",
                  "http://www.example.me/",
                  "http://www.amazon.com/gp/product/B00006ID1U/ref=as_li_qf_sp_asin_tl?ie=UTF8&camp=1789&creative=9325&creativeASIN=B00006ID1U&linkCode=as2&tag=thegoemypay-20"]
    valid_urls.each do |url|
      valid_url_product = Product.new(@attr.merge(:url => url))
      valid_url_product.should be_valid
    end
  end

  it "should not accept invalid product URLS" do
    invalid_urls = ["http://www.example./",
                  "http://www.example",
                  "http:/www.example.co.jp",
                  "www.example.me/",
                  ""]
    invalid_urls.each do |url|
      invalid_url_product = Product.new(@attr.merge(:url => url))
      invalid_url_product.should_not be_valid
    end
  end
end