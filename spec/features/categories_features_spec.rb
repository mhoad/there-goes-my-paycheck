require 'spec_helper'

describe 'Categories' do
  subject { page }
  let(:submit) { 'Create Category' }
  before { sign_in FactoryGirl.create(:admin_user) }


  describe 'new categories' do
    before { visit new_category_path }

    describe 'new category page' do
      it { should have_selector('h2', text: 'Add a new category')}
      it { should have_field('category_name')}
      it { should have_field('category_description')}
      it { should have_field('category_parent_id')}
    end

    describe 'add a new category' do
      before do
        fill_in 'category_name',         with: 'Kids stuff'
        fill_in 'category_description',  with: 'Lorem ipsum' * 100
        
      end

      it 'should add a new category' do
        expect { click_button submit}.to change(Category, :count).by(1)
      end

      describe 'category page should contain the correct information' do
        before { click_button submit }

        it { should have_content('Category sucessfully created')}
        it { should have_selector('h1', text: 'Kids stuff') }
        it { should have_content('Lorem ipsum') }
      end

      describe 'should not allow invalid information' do
        before do
          fill_in 'category_name',        with: 'a'
          fill_in 'category_description', with: 'short description'
          click_button submit
        end

        it { should have_content('must have at least 50 words')} #Description
        it { should have_content('minimum is 3 characters') } #Name
      end
    end
  end

  describe 'edit categories' do
    let(:submit) { 'Update Category' }
    let(:category) { FactoryGirl.create(:category) }
    before { visit edit_category_path(category) }

    describe 'edit category page' do
      it { should have_content('Edit Category') }
      it { should have_field('category_name') }
      it { should have_field('category_description') }
      it { should have_button(submit) }
    end

    describe 'update the category name' do
      context 'with valid information' do
        before do
          fill_in 'category_name', with: 'Gadgets'
          click_button submit
        end

        it { should have_content('Product sucessfully updated') }
        it { should have_content(category.name) }
      end

      context 'with invalid information' do
        before do
          fill_in 'category_name', with: 'ab'
          fill_in 'category_description', with: 'short description'
          click_button submit
        end

        it { should have_content('minimum is 3 characters') } #Name
        it { should have_content('must have at least 50 words') } #Description
      end
    end
  end

  describe 'view categories' do
    let(:category) { FactoryGirl.create(:category) }
    before { visit category_path(category) }
  
    it { should have_selector('h1', category.name) }
  end

  describe 'delete category' do
    let(:category) { FactoryGirl.create(:category) }
    before do
      visit category_path(category)
      click_link "Delete category"
    end

    it { should have_content ("Category successfully deleted") }
  end

  describe 'regular users' do
    before { click_link "Logout" }

    describe 'not able to create a new category' do
      before { visit new_category_path }

      it { should_not have_selector('h2', text: 'Add a new category')}
      it { should_not have_field('category_name')}
      it { should_not have_field('category_description')}
      it { should_not have_field('category_parent_id')}
    end

    describe 'not able to edit a category' do
      let(:category) { FactoryGirl.create(:category) }
      before { visit edit_category_path(category) }

      it { should_not have_content('Edit Category') }
      it { should_not have_field('category_name') }
      it { should_not have_field('category_description') }
    end

    describe 'not able to delete a category' do
      let(:category) { FactoryGirl.create(:category) }
      before { visit category_path(category) }

      it { should_not have_link('Delete category') }
    end

    describe 'can view a category' do
      let(:category) { FactoryGirl.create(:category) }
      before { visit category_path(category) }

      it { should have_content (category.name) }
      it { should have_content (category.description) }
    end

  end

end