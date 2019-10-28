class Task < ApplicationRecord
  validates :task, presence: true
  belongs_to :user
  scope :ordered_by_deadline, -> { order(deadline: :asc) }
  
  include AASM
  aasm column: :state do
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
