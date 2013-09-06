require 'spec_helper'

feature 'Editing Products' do
  let(:submit) { 'Update Product' }
  let!(:category) { FactoryGirl.create(:category, name: "Toys") }
  let!(:product) { FactoryGirl.create(:product, category: category) }

  before do
    sign_in FactoryGirl.create(:admin_user)
    visit edit_category_product_path(category, product)
  end

  scenario 'edit products page contains the correct form' do
    expect(page).to have_selector('h2', text: 'Edit Product')
    expect(page).to have_field('product_name', 
                                :with => product.name)
    expect(page).to have_field('product_description',
                                :with => product.description)
    expect(page).to have_field('product_url',
                                :with => product.url)
  end

  scenario 'edit product with valid attributes' do
    fill_in 'product_name',         with: 'Laser Pointer'
    fill_in 'product_description',  with: 'Lorem Ipsum' * 30
    fill_in 'product_url',          with: 'http://www.sample.com/'
    click_button submit

    expect(page).to have_content('Product successfully updated')
    expect(page).to have_content('Laser Pointer')
    expect(page).to have_content('Lorem Ipsum')
    expect(page).to have_link('www.sample.com', href:'http://www.sample.com/' )

  end

  scenario 'edit product with invalid attributes' do
    fill_in 'product_name', with: ''
    fill_in 'product_description', with: ''
    fill_in 'product_url', with: ''
    click_button submit

    expect(page).to have_content('Product not updated')
    expect(page).to have_content("Name can't be blank")
    expect(page).to have_content("Description must have at least 30 words")
    expect(page).to have_content("Url can't be blank")
    expect(page).to have_content("Url is invalid")
  end

  scenario 'attempt to edit product as a regular user' do
    click_link "Logout"
    visit edit_category_product_path(category, product)
    expect(page).to have_content('You must be logged in')
    expect(page).to_not have_content('Edit Product')
  end

  scenario 'Edit product link should appear on product page for admin users' do
    visit category_product_path(category, product)
    expect(page).to have_link('Edit Product')
  end

  scenario 'Edit product link should not appear on page for regular users' do
    click_link "Logout"
    visit category_product_path(category, product)
    expect(page).to_not have_link('Edit Product')
  end
end
