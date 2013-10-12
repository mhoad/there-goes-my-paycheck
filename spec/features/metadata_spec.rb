require 'spec_helper'

feature 'Metadata' do
    let!(:category)     { FactoryGirl.create(:category) }
    let!(:subcategory)  { FactoryGirl.create(:subcategory, 
                          parent_category: category) }
    let!(:product)      { FactoryGirl.create(:product, category: category) }

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

  scenario "product pages contain the correct title tags" do
    visit category_product_path(category, product)

    page.should have_title "#{product.category.name}: #{product.name}"
  end

  scenario "category pages should have the correct title tags" do
    visit category_path(category)

    page.should have_title category.name
  end

  scenario "sub-category pages should have the correct title tags" do
    visit category_path(subcategory)

    page.should have_title "#{subcategory.name} - #{subcategory.parent_category.name}"
  end

  scenario "static pages should have the correct title tags" do
    visit root_path
    page.should have_title "Unique Gifts and Products"

    visit about_path
    page.should have_title "About Us"

    visit submit_path
    page.should have_title "Submit a Product"

    visit privacy_path
    page.should have_title "Privacy Policy"

    visit facebook_path
    page.should have_title("")
  end
end


