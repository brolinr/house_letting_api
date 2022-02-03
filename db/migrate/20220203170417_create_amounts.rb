class CreateAmounts < ActiveRecord::Migration[6.1]
  def change
    create_table :amounts do |t|
      t.decimal :price
      t.belongs_to :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
