class Task < ApplicationRecord
  include AASM
  validates :title, presence: true
  enum priority: %i[low medium high]
  enum state: %i[todo doing completed]
  belongs_to :user, counter_cache: true
  has_many :taggings
  has_many :tags, through: :taggings

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

  def self.tagged_with(name)
    Tag.find_by!(name: name).tasks
  end

  def tag_list
    tags.map(&:name).join(', ')
  end

  def tag_list=(names)
    self.tags = names.split(',').map do |item|
      Tag.where(name: item.strip).first_or_create!
    end
  end
  
  def tag_items
    tags.map(&:name)
  end

  def tag_items=(names)
    self.tags = names.map{|item|
      Tag.where(name: item.strip).first_or_create! unless item.blank?}.compact!
  end

end
