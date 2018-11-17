FactoryBot.define do
  factory :task do
    sequence(:title) { |n| "task title #{n}" }
    sequence(:content) { |n| "task content #{n}" }
    priority { :low }
    deadline { 1.day.from_now }
    trait :deadline_next_week do
      deadline { 1.week.from_now }
    end
    trait :deadline_next_2_week do
      deadline { 2.week.from_now }
    end
    trait :high_priority do
      priority { :high }
    end
    trait :medium_priority do
      priority { :medium }
    end
  end
end