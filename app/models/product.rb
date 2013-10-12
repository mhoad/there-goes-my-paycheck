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
#  price                :decimal(, )
#

class Product < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: :slugged

  belongs_to :category

  has_attached_file :picture, :styles => { :medium => "640x480>" }
  has_attached_file :social_image

  validates_attachment :picture, :presence => true,
  :content_type => { :content_type => ["image/jpeg", "image/jpg", "image/png"] }

  validates_attachment :social_image, :presence => true,
  :content_type => { :content_type => ["image/jpeg", "image/jpg", "image/png"] }

  VALID_URL_REGEX = /\A^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$\z/ix

  validates :name, presence: true
  validates :description, :length => {
    :minimum   => 30,
    :tokenizer => lambda { |str| str.scan(/\w+/) },
    :too_short => "must have at least %{count} words"
  } # 50 word count minimum description
  validates :url, presence: true, format: { with: VALID_URL_REGEX }

  def tags
    product_tags = "all "
    product_tags << "premium "    if is_expensive_product?
    product_tags << "cheap "      if is_cheap_product?
    product_tags << "latest "     if is_latest_product?
    return product_tags.strip
  end

  private
    def is_latest_product?
      self.created_at > 30.days.ago
    end

    def is_expensive_product?
      if self.price.nil?
        return false
      else
        return true if self.price >= 100
      end
    end

    def is_cheap_product?
      if self.price.nil?
        return false
      else
        return true if self.price < 100
      end
    end
end
