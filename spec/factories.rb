FactoryBot.define do
  factory :tagging do
    
  end

  factory :tag do
    
  end

  factory :user do
    sequence(:username) { |num| "User #{num}" }
    sequence(:email) { |num| "#{num}@gmail.com" }
    sequence(:password) { "123456" }
  end
  factory :task do
    sequence(:task) { |num| "task title #{num}" }
    sequence(:content) { |num| "task content #{num}" }
    sequence(:deadline) { Time.zone.now }
  end
end