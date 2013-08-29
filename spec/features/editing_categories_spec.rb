require 'spec_helper'

feature 'Editing Categories' do
  let(:submit) { 'Update Category' }
  let!(:category) { FactoryGirl.create(:category) }

  before do
    sign_in FactoryGirl.create(:admin_user)
    visit edit_category_path(category)
  end

  scenario 'edit category page contains the correct information' do
    expect(page).to have_content('Edit Category')
    expect(page).to have_field('category_name')
    expect(page).to have_field('category_description')
    expect(page).to have_button(submit)
  end

  scenario 'edit category with valid attributes' do
    fill_in 'category_name', with: 'Gadgets'
    click_button submit

    expect(page).to have_content('Category sucessfully updated')
    expect(page).to have_content(category.name)
  end

  scenario 'edit category with invalid attributes' do
    fill_in 'category_name',        with: 'a'
    fill_in 'category_description', with: 'short description'
    click_button submit

    expect(page).to have_content('Category not updated')
    expect(page).to have_content('descriptionmust have at least 50 words')
    expect(page).to have_content('Nameis too short')
  end

  scenario 'attempt to edit category as a regular user' do
    click_link "Logout"
    visit edit_category_path(category)

    expect(page).to have_content('You must be logged in')
    expect(page).to_not have_content('Edit Category')
  end
end