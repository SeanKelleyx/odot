FactoryGirl.define do 
  
  factory :user do 
    first_name            "First"
    last_name             "Last"
    sequence(:email)      { |n| "user#{n}@odot.com" }
    password              "tester1"
    password_confirmation "tester1"
  end  

  factory :todo_list do 
    title                 "Groceries"
    description           "Grocery list."
    user #declaring user lets factory girl know the association
  end
end