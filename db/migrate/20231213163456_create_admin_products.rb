class CreateAdminProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :products do |t|
      t.string :name
      t.text :description
      t.integer :price
      t.references :category, null: false, foreign_key: true
      t.boolean :active

      t.timestamps
    end
  end
end
