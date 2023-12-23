class CreateAdminStocks < ActiveRecord::Migration[7.1]
  def change
    create_table :stocks do |t|
      t.string :size
      t.integer :amount
      t.references :product, null: false, foreign_key: true

      t.timestamps
    end
  end
end
