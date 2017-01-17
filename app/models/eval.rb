class Eval < ActiveRecord::Base
  belongs_to :evaluatee, class_name: 'User'
  belongs_to :evaluator, class_name: 'User'

  validates :level, presence: true

  enum level: { very_good: 3, good: 2, bad: 1, very_bad: 0 }
end
