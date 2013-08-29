require 'spec_helper'

feature 'Creating Categories' do
  let(:submit) { 'Create Category' }
  
  before do
    sign_in FactoryGirl.create(:admin_user)
    visit new_category_path
  end

  scenario 'new category page contains correct information' do
    expect(page).to have_selector('h2', text: 'Add a new category')
    expect(page).to have_field('category_name')
    expect(page).to have_field('category_description')
    expect(page).to have_field('category_parent_id')
  end

  scenario 'add a new category with valid attributes' do
    fill_in 'category_name',         with: 'Kids stuff'
    fill_in 'category_description',  with: 'Lorem ipsum' * 100

    expect { click_button submit }.to change(Category, :count).by(1)
    expect(page).to have_content('Category sucessfully created')
    expect(page).to have_selector('h3', text: 'Kids stuff')
    expect(page).to have_content('Lorem ipsum')
  end

  scenario 'add a new category with invalid attributes' do
    fill_in 'category_name',        with: 'a'
    fill_in 'category_description', with: 'short description'
    click_button submit

    expect(page).to have_content('Category not created')
    expect(page).to have_content('descriptionmust have at least 50 words')
    expect(page).to have_content('Nameis too short')
  end

  scenario 'attempt to add a new category as a regular user' do
    click_link "Logout"
    visit new_category_path

    expect(page).to have_content('You must be logged in')
    expect(page).to_not have_selector('h2', text: 'Add a new category')
  end
end

