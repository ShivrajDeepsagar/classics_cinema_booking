class CreateTheaterTables < ActiveRecord::Migration[5.0]
  def change
    create_table :theater_tables do |t|
      t.string :theater_name, null: false
      t.integer :no_of_shows, default:4
      t.integer :total_seates, default: 100
      t.string :address
      t.timestamps
    end
  end
end
