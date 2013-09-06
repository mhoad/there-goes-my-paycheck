require 'spec_helper'

feature 'deleting products' do
  let!(:category) { FactoryGirl.create(:category) }
  let!(:product) { FactoryGirl.create(:product, category: category) }

  before do
    sign_in FactoryGirl.create(:admin_user)
    visit category_product_path(category, product)
  end

  scenario 'product page contains a delete link for admin users' do
    expect(page).to have_link('Delete Product')
  end

  scenario 'delete product link should not appear for regular users' do
    click_link "Logout"
    visit category_product_path(category, product)

    expect(page).to_not have_link('Delete Product')
  end

  scenario 'clicking the delete product link should delete the product' do
    expect { click_link('Delete Product') }.to change(Product, :count).by(-1)
  end

end
