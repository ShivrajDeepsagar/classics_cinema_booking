class UpdatingSeatsTable < ActiveRecord::Migration[5.0]
  def change
  	add_column :seats, :seat_numbers,:integer, array: true, default: []
    add_column :seats, :seat_rows,:string, array: true, default: []
    add_reference :seats, :reservations, index: true
    add_reference :seats, :users, index: true
  end
end
