# == Schema Information
#
# Table name: products
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :text
#  url         :text
#  created_at  :datetime
#  updated_at  :datetime
#  category_id :integer
#

class Product < ActiveRecord::Base
  belongs_to :category

  VALID_URL_REGEX = /\A^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$\z/ix

  validates :name, presence: true
  validates :description, :length => {
    :minimum   => 30,
    :tokenizer => lambda { |str| str.scan(/\w+/) }, 
    :too_short => "must have at least %{count} words"
  } # 50 word count minimum description
  validates :url, presence: true, format: { with: VALID_URL_REGEX }
end
