class ImproveDatabase < ActiveRecord::Migration[6.1]
  def change
    remove_column(:properties, :contact)

    add_column :properties, :owner_phone, :string
    add_column :properties, :owner_whatsapp, :string
    add_column :properties, :owner_email, :string
    add_column :properties, :slug, :string

    add_column :feedbacks, :feedback_type, :integer, default: 0
  end
end
