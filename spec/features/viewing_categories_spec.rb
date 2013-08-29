require 'spec_helper'

feature 'Viewing Categories' do
  let!(:category) { FactoryGirl.create(:category) }
  let!(:subcategory) { FactoryGirl.create(:subcategory, parent_category: category) }

  scenario 'category appears on the homepage' do
    visit root_path

    expect(page).to have_content(category.name)
  end

  scenario 'subcategory does not appear on homepage' do
    visit root_path
    expect(page).to_not have_content(subcategory.name)
  end

  scenario 'category pages contain the correct information' do
    visit category_path(category)

    expect(page).to have_content(category.name)
    expect(page).to have_content(category.description)
    expect(page).to_not have_content(subcategory.description)
  end

  scenario 'subcategory pages contain the correct information' do
    visit category_path(subcategory)

    expect(page).to have_content(subcategory.name)
    expect(page).to have_content(subcategory.description)
    expect(page).to_not have_content(category.description)
  end

end