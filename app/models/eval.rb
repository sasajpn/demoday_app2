class Eval < ActiveRecord::Base
  belongs_to :evaluatee, class_name: 'User'
  belongs_to :evaluator, class_name: 'User'
end
