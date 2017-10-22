class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.string :name
      t.string :url
      t.string :us_item_id
      t.string :product_id, index: true
      t.float  :price
      t.float  :price_min
      t.string :price_min_currency
      t.float  :price_max
      t.string :price_max_currency

      t.timestamps null: false
    end
  end
end
