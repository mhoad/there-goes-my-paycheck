require 'spec_helper'

feature 'Viewing Products' do
  let!(:category) { FactoryGirl.create(:category, name: "Toys") }
  let!(:product) { FactoryGirl.create(:product, category: category) }

  scenario 'product appears on the category page' do
    visit category_path(category)
    
    expect(page).to have_content(product.name)
  end

  scenario 'product appears correctly on the homepage' do
    visit root_path

    expect(page).to have_content(product.name)
  end

  scenario 'can navigate to product from homepage' do
    visit root_path
    click_link product.name

    expect(page).to have_content(product.description)
  end

  scenario 'product pages contain the correct information' do
    visit category_path(category)
    click_link product.name

    expect(page).to have_content(product.name)
    expect(page).to have_content(product.description)
  end
end