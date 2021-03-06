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

include ApplicationHelper

class Category < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: :slugged

  has_many :subcategories, :class_name => "Category", :foreign_key => "parent_id", :dependent => :destroy
  belongs_to :parent_category, :class_name => "Category", :foreign_key=>"parent_id"
  has_many :products, dependent: :destroy


  validates :name, :description, presence: true
  validates :name, :length => { :minimum => 3 }
  validates :description, :length => {
    :minimum   => 50,
    :tokenizer => lambda { |str| str.scan(/\w+/) },
    :too_short => "must have at least %{count} words"
  } # 50 word count minimum description

end
