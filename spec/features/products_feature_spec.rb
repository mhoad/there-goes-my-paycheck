require 'spec_helper'

describe 'Products' do
  subject { page }
  let(:submit) { 'Create Product' }
  before do
    sign_in FactoryGirl.create(:admin_user)
    @sample_category = FactoryGirl.create(:category)
  end

  describe 'new products' do
    before { visit new_category_product_path(@sample_category) }

    describe 'new products page' do
      it { should have_selector('h2', text: 'Add a new product') }
      it { should have_field('product_name') }
      it { should have_field('product_description') }
      it { should have_field('product_url') }
    end

    describe 'add a new product' do
      before do
        fill_in 'product_name',         with: 'Sample Product'
        fill_in 'product_description',  with: 'Lorem ipsum' * 30
        fill_in 'product_url',          with: 'http://www.example.com/'
      end

      it 'should add a new product' do
        expect { click_button submit }.to change(Product, :count).by(1)
      end

      describe 'product page' do
        before { click_button submit }

        it { should have_content('Product successfully created') }
        it { should have_content('Sample Product') }
        it { should have_content('Lorem ipsum') }
        it { should have_content('http://www.example.com/') }
      end
    end
  end
end