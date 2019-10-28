class Task < ApplicationRecord
  validates :task, presence: true
  belongs_to :user
  scope :ordered_by_deadline, -> { order(deadline: :asc) }
end
