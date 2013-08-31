# == Schema Information
#
# Table name: categories
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  parent_id   :integer
#  created_at  :datetime
#  updated_at  :datetime
#  description :text
#  slug        :string(255)
#

require 'spec_helper'

describe Category do
  before(:each) do
    @attr = { 
      :name => "Category Name",
      :description => "Lorem ipsum" * 100 }
  end

  it "should create a new instance given a valid attribute" do
    Category.create!(@attr).should be_valid
  end

  it "should require a category name" do
    no_name_category = Category.new(@attr.merge(:name => ""))
    no_name_category.should_not be_valid
  end

  it "should require a category description" do
    no_description_category = Category.new(@attr.merge(:description => ""))
    no_description_category.should_not be_valid
  end

  it "should not accept short category descriptions" do
    no_description_category = Category.new(@attr.merge(:description => "short description"))
    no_description_category.should_not be_valid
  end

  it "should not accept short product names" do
    short_category_name = Category.new(@attr.merge(:name => "a"))
    short_category_name.should_not be_valid
  end
end
