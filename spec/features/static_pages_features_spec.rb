require 'spec_helper'

describe 'StaticPages' do
  describe 'Homepage' do
    it 'should have the correct content' do
      visit root_path
      expect(page).to have_content('FMH Gifts')
    end
  end

  describe 'About Us Page' do
    it 'should have the correct heading' do
      visit about_path
      expect(page).to have_content('About Us')
    end
  end

  describe 'Submit Product Page' do
    it 'should have the correct heading' do
      visit submit_path
      expect(page).to have_content('Submit a Product')
    end
  end
end