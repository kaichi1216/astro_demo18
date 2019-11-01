class Task < ApplicationRecord
  validates :task, presence: true
  belongs_to :user
  scope :ordered_by_deadline, -> { order(deadline: :asc) }
  enum state: %i[pending processing solved]
  enum priority: %i[low middle high]
  scope :ordered, lambda { |order_by_port| order(order_by_port || 'deadline ASC')  }
  
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
end
