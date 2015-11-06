FactoryGirl.define do 
  
  factory :user do 
    first_name            "First"
    last_name             "Last"
    sequence(:email)      { |n| "user#{n}@odot.com" }
    password              "tester1"
    password_confirmation "tester1"
  end  

end