class CreateBookings < ActiveRecord::Migration[7.0]
  def change
    create_table :bookings do |t|
      t.references :user, null: false, foreign_key: true
      t.references :service, null: false, foreign_key: true
      t.integer :status, default: 0
      t.datetime :start_date
      t.datetime :end_date

      t.timestamps
    end
  end
end
