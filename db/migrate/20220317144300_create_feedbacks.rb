class CreateFeedbacks < ActiveRecord::Migration[6.1]
  def change
    create_table :feedbacks do |t|
      t.text :description
      t.belongs_to :customer, null: false, foreign_key: true
      t.timestamps
    end
  end
end
