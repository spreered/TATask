class Task < ApplicationRecord
  include AASM
  validates :title, presence: true
  scope :ordered, lambda {|*args| order(args.first || 'created_at DESC') }
  enum priority: %i[low medium high]
  enum state: %i[todo doing completed]


  aasm column: :state, enum: true do
    state :todo, initial: true
    state :doing, :completed

    event :start do
      transitions from: :todo, to: :doing
    end
    event :done do
      transitions from: %i[todo doing], to: :completed
    end
  end
end
