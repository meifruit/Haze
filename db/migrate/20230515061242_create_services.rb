class CreateServices < ActiveRecord::Migration[7.0]
  def change
    create_table :services do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :price
      t.text :description
      t.string :title

      t.timestamps
    end
  end
end
