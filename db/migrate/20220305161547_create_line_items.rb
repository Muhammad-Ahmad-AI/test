class CreateLineItems < ActiveRecord::Migration[5.2]
  def change
    create_table :line_items do |t|
      t.integer :unit_price
      t.integer :quantity
      t.integer :total_price
      t.references :product, foreign_key: true
      t.references :line_itemable, polymorphic: true

      t.timestamps
    end
  end
end
