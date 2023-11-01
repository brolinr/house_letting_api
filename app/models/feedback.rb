# frozen_string_literal: true

class Feedback < ApplicationRecord
  belongs_to :customer, foreign_key: 'user_id'

  enum feedback_type: { complaint: 0, appraisal: 1, problem: 2, bug: 3, subscription: 4 }

  validates :description, presence: true
  validates :feedback_type, presence: true
end
