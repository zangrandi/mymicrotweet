FactoryGirl.define do
  factory :user do
  	sequence :email do |n|
			"example#{n}@email.com"
  	end
		password "123456"
		sequence :username do |n|
			"example#{n}"
		end
		fullname "Factory User"
  end
end
