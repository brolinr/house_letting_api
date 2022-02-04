class AddPhoneToSubscriptions < ActiveRecord::Migration[6.1]
  def change
    add_column :subscriptions, :phone, :string
  end
end
