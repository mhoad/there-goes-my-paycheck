FactoryGirl.define do
  factory :category do  
    name         "Gadgets"
    description  "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
                  tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,
                  quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo
                  consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse
                  cillum dolore eu fugiat nulla pariatur"
  end

  factory :subcategory, class: Category do
    name        "Technology"
    description "Bacon ipsum dolor sit amet short ribs salami tenderloin filet mignon brisket, 
                spare ribs jowl bacon shoulder bresaola t-bone biltong chicken frankfurter pork. 
                Shank doner meatball turducken beef pork belly salami ribeye filet mignon pork chop 
                leberkas bresaola. Boudin short loin beef ribs prosciutto turducken, salami jerky venison. 
                Tongue cow biltong tri-tip short ribs. Kielbasa rump tenderloin swine brisket, 
                turducken pastrami corned beef biltong pork belly."
    parent_category   1
  end
end