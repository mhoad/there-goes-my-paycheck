# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :product do
    name "Sample Product Name"
    description "Bacon ipsum dolor sit amet chicken andouille short 
                ribs cow swine shoulder. Capicola turducken pork 
                t-bone strip steak. Short loin boudin beef andouille 
                filet mignon corned beef cow kielbasa pastrami. 
                Salami strip steak doner, t-bone venison short ribs 
                boudin sirloin swine corned beef pig leberkas turkey 
                pork chop. Tail pastrami fatback swine, pork belly 
                tri-tip pork loin."
    url "http://www.example.com/"
    picture File.new(Rails.root + 'spec/factories/images/1024x680.jpg')
    social_image File.new(Rails.root + 'spec/factories/images/1024x680.jpg') 
    price 40.00
  end
end
