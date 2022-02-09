class AddFieldsToSubscriptions < ActiveRecord::Migration[6.1]
  def change
    add_column :subscriptions, :poll_url, :string
    add_column :subscriptions, :month, :string
    add_column :subscriptions, :ecocash_number, :string
  end
end
