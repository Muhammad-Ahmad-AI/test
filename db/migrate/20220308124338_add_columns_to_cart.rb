class AddColumnsToCart < ActiveRecord::Migration[5.2]
  def change
    add_column :carts, :sub_total, :integer
    add_column :carts, :total , :integer
  end
end
