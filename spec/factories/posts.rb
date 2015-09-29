FactoryGirl.define do
  factory :post do
  	sequence(:text) do |n|
  		"Post #{n}#{rand(100)}"
  	end
  	user
  end
end
