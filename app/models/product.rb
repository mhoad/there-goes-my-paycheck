# == Schema Information
#
# Table name: products
#
#  id                   :integer          not null, primary key
#  name                 :string(255)
#  description          :text
#  url                  :string(255)
#  created_at           :datetime
#  updated_at           :datetime
#  category_id          :integer
#  slug                 :string(255)
#  picture_file_name    :string(255)
#  picture_content_type :string(255)
#  picture_file_size    :integer
#  picture_updated_at   :datetime
#

class Product < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: :slugged

  has_attached_file :picture, :styles => { :medium => "640x480>" }
  
  belongs_to :category

  VALID_URL_REGEX = /\A^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$\z/ix

  validates_attachment :picture, :presence => true,
  :content_type => { :content_type => ["image/jpeg", "image/jpg", "image/png"] }

  validates :name, presence: true
  validates :description, :length => {
    :minimum   => 30,
    :tokenizer => lambda { |str| str.scan(/\w+/) }, 
    :too_short => "must have at least %{count} words"
  } # 50 word count minimum description
  validates :url, presence: true, format: { with: VALID_URL_REGEX }
end
