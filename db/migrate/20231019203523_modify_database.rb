class ModifyDatabase < ActiveRecord::Migration[6.1]
  def change
    drop_table(:active_storage_attachments, if_exists: true, force: :cascade)
    drop_table(:active_storage_blobs, if_exists: true, force: :cascade)
    drop_table(:active_storage_variant_records, if_exists: true, force: :cascade)
    drop_table(:customers, if_exists: true, force: :cascade)

    remove_column(:feedbacks, :customer_id)
    remove_columns(:subscriptions, :status, :customer_id, :phone)
    remove_column(:users, :password_digest)

    add_column :users, :type, :string

    add_reference :feedbacks, :user, null: false, index: false
    add_reference :subscriptions, :user,null: false, index: false

    add_foreign_key :feedbacks, :users, column: :user_id
    add_foreign_key :subscriptions, :users, column: :user_id

    add_column :subscriptions, :payment_status, :integer, default: 0
    add_column :subscriptions, :fee, :integer, default: 0
    add_column :properties, :location, :string
  end
end
