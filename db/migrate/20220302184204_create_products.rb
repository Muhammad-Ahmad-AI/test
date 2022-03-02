class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :name
      t.string :description
      t.string :picture
      t.integer :quantity
      t.integer :price
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
