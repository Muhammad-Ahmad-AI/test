class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.integer :total
      t.string :stripe_charge_id
      t.integer :status
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
