class CreateMovieTables < ActiveRecord::Migration[5.0]
  def change
    create_table :movie_tables do |t|
      t.string :movie_name, null: false
      t.integer :duration, null: false
      t.timestamps
    end
  end
end
