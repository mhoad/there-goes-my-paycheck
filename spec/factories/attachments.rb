FactoryGirl.define do
  factory :product_picture do
    picture File.new(Rails.root + 'spec/factories/images/1024x680.jpg') 
  end
end