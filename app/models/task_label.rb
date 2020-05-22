class TaskLabel < ApplicationRecord
  belongs_to :tasl, optional: true
  belongs_to :label, optional: true
end
