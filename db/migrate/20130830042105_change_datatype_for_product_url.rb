class ChangeDatatypeForProductUrl < ActiveRecord::Migration
  def self.up
    change_table :products do |t|
      t.change :url, :string
    end
  end

  def self.down
    change_table :products do |t|
      t.change :url, :text
    end
  end
end
