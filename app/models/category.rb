class Category < ActiveRecord::Base
  has_many :subcategories, :class_name => "Category", :foreign_key => "parent_id", :dependent => :destroy
  belongs_to :parent_category, :class_name => "Category", :foreign_key=>"parent_id"

  validates :name, :description, presence: true
  validates :name, :length => { :minimum => 3 }
  validates :description, :length => {
    :minimum   => 50,
    :tokenizer => lambda { |str| str.scan(/\w+/) }, 
    :too_short => "must have at least %{count} words"
  } # 50 word count minimum description
end
