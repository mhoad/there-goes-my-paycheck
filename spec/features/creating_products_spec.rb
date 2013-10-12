require 'spec_helper'

feature 'Creating Products' do
  let(:submit) { 'Create Product' }

  before do
    sign_in FactoryGirl.create(:admin_user)
    @sample_category = FactoryGirl.create(:category, name: "Toys")
    visit new_category_product_path(@sample_category)
  end

  scenario 'new products page contains the correct form' do
    expect(page).to have_selector('h2', text: 'Add a new product')
    expect(page).to have_field('product_name')
    expect(page).to have_field('product_description')
    expect(page).to have_field('product_url')
  end

  scenario 'add a new product' do
    file_path = File.join(Rails.root,'spec/factories/images/1024x680.jpg')
    
    fill_in 'product_name',         with: 'Sample Product'
    fill_in 'product_description',  with: 'Lorem ipsum' * 30
    fill_in 'product_url',          with: 'http://www.example.com/'
    page.attach_file 'product_picture', file_path
    page.attach_file 'product_social_image', file_path
    
    expect { click_button submit }.to change(Product, :count).by(1)
    expect(page).to have_content('Product successfully created')
    expect(page).to have_content('Sample Product')
    expect(page).to have_content('Lorem ipsum')
    expect(page).to have_link('www.example.com', href:'http://www.example.com/' )
  end

  scenario 'attempt to create a product with invalid attributes' do
    expect { click_button submit }.to_not change(Product, :count).by(1)
    expect(page).to have_content('Product not created')
    expect(page).to have_content("Name can't be blank")
    expect(page).to have_content("Description must have at least 30 words")
    expect(page).to have_content("Url can't be blank")
    expect(page).to have_content("Url is invalid")
  end


end