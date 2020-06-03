class Label < ApplicationRecord
  has_many :task_labels, dependent: :destroy, foreign_key: 'label_id'
  has_many :posts, through: :task_labels, source: :task
end
