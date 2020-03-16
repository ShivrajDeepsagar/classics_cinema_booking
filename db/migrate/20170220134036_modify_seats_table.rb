class ModifySeatsTable < ActiveRecord::Migration[5.0]
  def change
  	 remove_column :seats, :seat_numbers
  	 remove_column :seats, :seat_rows
  	 add_column :seats, :seat_details,:string, array: true, default: []
  end
end
