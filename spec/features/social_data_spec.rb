require 'spec_helper'

feature 'Social Metadata' do
    let!(:category) { FactoryGirl.create(:category) }
    let!(:product) { FactoryGirl.create(:product, category: category) }

  scenario "page contains Facebook open graph data" do
    visit category_product_path(category, product)
    
    page.should have_css 'meta[property="fb:app_id"]',        :visible => false
    page.should have_css 'meta[property="og:title"]',         :visible => false
    page.should have_css 'meta[property="og:type"]',          :visible => false
    page.should have_css 'meta[property="og:image"]',         :visible => false
    page.should have_css 'meta[property="og:url"]',           :visible => false
    page.should have_css 'meta[property="og:description"]',   :visible => false
  end

  scenario "page contains Twitter cards metadata" do
    visit category_product_path(category, product)

    page.should have_css 'meta[property="twitter:site"]',         :visible => false
    page.should have_css 'meta[property="twitter:creator"]',      :visible => false
    page.should have_css 'meta[property="twitter:card"]',         :visible => false
    
  end
end


