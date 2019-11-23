class Task < ApplicationRecord
  belongs_to :user, counter_cache: true
  validates :task, presence: true
  scope :ordered_by_deadline, -> { order(deadline: :asc) }
  enum state: %i[pending processing solved]
  enum priority: %i[low middle high]
  scope :ordered, lambda { |order_by_port| order(order_by_port || 'deadline ASC')  }
  has_many :taggings, :dependent => :nullify
  has_many :tags, through: :taggings, :dependent => :nullify
  
  include AASM
  aasm column: :state, enum: true do
    state :pending, initial: true
    state :processing, :solved

    event :start do
      transitions from: :pending, to: :processing
    end

    event :done do
      transitions from: %i[pending, processing], to: :solved
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
    self.tags = names.map{ |item| Tag.where(name: item.strip).first_or_create! unless item.blank?}.compact!
  end
end
