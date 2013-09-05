class AddIndexToProducts < ActiveRecord::Migration
  def self.up
   add_index :products, :category_id
  end

  def self.down
    remove_index :products, :category_id
  end
end
