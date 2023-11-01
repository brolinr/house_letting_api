# frozen_string_literal: true

class Customer < User
  has_many :subscriptions, foreign_key: 'user_id', class_name: 'Subscription', dependent: :destroy
  has_many :feedbacks, foreign_key: 'user_id', class_name: 'Feedback', dependent: :nullify

  validates :phone, presence: true, uniqueness: true
  validates :name, presence: true, uniqueness: true

  def subscribed?
    return false if subscriptions.empty? || subscriptions.last.payment_status != :paid

    subscription_deadline = subscriptions.last.created_at + 30.days
    subscription_deadline > Time.zone.now
  end
end
