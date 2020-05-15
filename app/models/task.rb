class Task < ApplicationRecord
  validates :name, presence: true
  validates :description, presence: true
  enum status: %i[未着手 着手中 完了]
  enum priority: %i[高 中 低]
end
