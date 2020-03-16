class RenamingIndexNamesForAssociations < ActiveRecord::Migration[5.0]
  def change
  	rename_column :transactions, :seats_id, :seat_id
  	rename_column :transactions, :reservations_id, :reservation_id
  	rename_column :transactions, :screenings_id, :screening_id
  	rename_column :seats, :reservations_id, :reservation_id
  	rename_column :seats, :users_id, :user_id
  	rename_column :reservations, :screenings_id, :screening_id
  	rename_column :reservations, :users_id, :user_id
  end
end
