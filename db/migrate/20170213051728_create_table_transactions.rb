class CreateTableTransactions < ActiveRecord::Migration[5.0]
  def change
    create_table :transactions do |t|
	  t.integer  "seats_id"
	  t.integer  "reservations_id"
	  t.integer  "screenings_id"
	  t.datetime "created_at", null: false
	  t.datetime "updated_at", null: false
	  t.index ["reservations_id"], name: "index_seat_reserved_on_reservations_id", using: :btree
	  t.index ["screenings_id"], name: "index_seat_reserved_on_screenings_id", using: :btree
	  t.index ["seats_id"], name: "index_seat_reserved_on_seats_id", using: :btree
    end
  end
end