FactoryGirl.define do
  factory :user do
  
    #Here sequence takes a symbol corresponding to the desired attribute 
    #(such as :name) and a block with one variable, which we have called n
    sequence(:name) { |n| "Person #{n}" }
    sequence(:email) { |n| "person_#{n}@example.com" }
    
    password  "foobar"
    password_confirmation "foobar" 
    
    factory :admin do
      admin true
    end
  end
  
  factory :micropost do
    content "Lorem ipsum"
    user
  end
end
