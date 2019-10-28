FactoryBot.define do
  factory :task do
    sequence(:task) { |num| "task title #{num}" }
    sequence(:content) { |num| "task content #{num}" }
    sequence(:deadline) { Time.zone.now }
  end
end