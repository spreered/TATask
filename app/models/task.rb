class Task < ApplicationRecord
  validates :title, presence: true
  scope :ordered, lambda {|*args| order(args.first || 'created_at DESC') }
  enum priority: %i[low medium high]
end
