class Task < ApplicationRecord
  validates :name, presence: true
  validates :description, presence: true
  enum status: %i[未着手 着手中 完了]
  enum priority: %i[高 中 低]
  belongs_to :user
  has_many :task_labels, dependent: :destroy, foreign_key: 'task_id'
  has_many :labels, through: :task_labels, source: :label
end
