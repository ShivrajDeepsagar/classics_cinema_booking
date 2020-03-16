class ChangeReferences < ActiveRecord::Migration[5.0]
  def change
  	rename_column :screenings, :movie_tables_id, :movie_id
  	rename_column :screenings, :theater_tables_id, :theater_id
  end
end
