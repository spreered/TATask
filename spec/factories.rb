FactoryBot.define do
  factory :tagging do
    tag { nil }
    taks { nil }
  end
  factory :tag do
    name { "MyString" }
  end
  factory :user do
    sequence(:email) {|n| "user_#{n}@example.com"}
    sequence(:name) {|n| "User #{n}"}
    password { "123456" }
    password_confirmation { "123456" }
  end
  factory :task do
    sequence(:title) { |n| "task title #{n}" }
    sequence(:content) { |n| "task content #{n}" }
    priority { :low }
    deadline { 1.day.from_now }
    state {:todo}
    association :user
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
    trait :doing_state do
      state { :doing }
    end
    trait :completed_state do
      state { :completed }
    end
  end
end