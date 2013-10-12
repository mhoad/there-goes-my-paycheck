class AddSocialImageToProducts < ActiveRecord::Migration
  def self.up
    change_table :products do |t|
    t.attachment :social_image
    end
  end

  def self.down
    drop_attached_file :products, :social_image
  end
end