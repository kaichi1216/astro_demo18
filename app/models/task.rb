class Task < ApplicationRecord

  include AASM
  aasm column: :state, enum: true do
    state :pending, initial: true
    state :processing, :solved

    event :start do
      transitions from: :pending, to: :processing
    end

    event :done do
      transitions from: %i[pending processing], to: :solved
    end
  end
  
  belongs_to :user, counter_cache: true
  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings
  validates :task, presence: true
  scope :ordered_by_deadline, -> { order(deadline: :asc) }
  scope :ordered, lambda { |order_by_port| order(order_by_port || 'deadline ASC')  }
  enum state: %i[pending processing solved]
  enum priority: %i[low middle high]
  


  def self.tagged_with(name)
    Tag.find_by(name: name).tasks
  end
  #getter
  def tag_list
    tags.map(&:name).join(', ')
  end
  #setter
  def tag_list=(names)
    names.split.filter { |item| !item.strip.blank? }.map do |item|
      Tag.where(name: item).first_or_create!
    end     
  end  
  #取出所有的tag name
  def tag_items
    tags.map(&:name)
  end
  #compact 刪除nil 元素
  def tag_items=(names)
    self.tags = names.map{ |item| Tag.where(name: item.strip).first_or_create! unless item.blank?}.compact!
  end
end
