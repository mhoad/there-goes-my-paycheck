require 'spec_helper'

feature 'Deleting Categories' do
  let!(:category) { FactoryGirl.create(:category) }

  before do
    sign_in FactoryGirl.create(:admin_user)
    visit category_path(category)
  end

  scenario 'Delete a category' do
    expect { click_link "Delete category" }.to change(Category, :count).by(-1)
    expect(page).to have_content ("Category successfully deleted")
  end

  scenario 'Attempt to delete a category as a regular user' do
    click_link "Logout"
    visit category_path(category)

    expect(page).to_not have_link('Delete category')
  end
end