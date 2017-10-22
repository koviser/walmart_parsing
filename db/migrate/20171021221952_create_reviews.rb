class CreateReviews < ActiveRecord::Migration[5.1]
  def change
    create_table :reviews do |t|
      t.belongs_to :product, null: false

      t.string :review_id, index: true
      t.string :author_id
      t.string :rating
      t.string :title
      t.string :text
      t.string :submission_time
      t.string :user_nickname

      t.timestamps null: false
    end
  end
end
