FactoryBot.define do
  factory :task do
    sequence(:task) { |num| "task title #{num}" }
    sequence(:content) { |num| "task content #{num}" }
    sequence(:remenber_created_at) { Time.zone.now }
  end
end