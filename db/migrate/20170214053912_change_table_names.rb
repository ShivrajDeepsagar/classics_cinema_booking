class ChangeTableNames < ActiveRecord::Migration[5.0]
  def change
  	rename_table :movie_tables, :movies
  	rename_table :theater_tables, :theaters
  end
end
