# frozen_string_literal: true

class Customer < User
  belongs_to :user

  has_many :subscriptions
  has_many :feedbacks

  validates :phone, presence: true, uniqueness: true
  validates :name, presence: true, uniqueness: true

  def subscribed?
    return false if subscriptions.empty? || subscriptions.last.payment_status != :paid
    subscription_deadline = subscriptions.last.created_at + 30.days
    subscription_deadline > Time.now
  end
end
