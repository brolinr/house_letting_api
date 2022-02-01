class AddContactToProperties < ActiveRecord::Migration[6.1]
  def change
    add_column :properties, :contact, :string
  end
end
