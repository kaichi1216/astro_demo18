class Tag < ApplicationRecord
  has_many :taggings, :dependent => :nullify
  has_many :tasks, through: :taggings
end
