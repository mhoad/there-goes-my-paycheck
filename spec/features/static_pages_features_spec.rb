require 'spec_helper'

describe "StaticPages" do
  describe "Homepage" do
    it "should have the correct content" do
      visit root_path
      expect(page).to have_content("Hello")
    end
  end
end