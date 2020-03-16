class CreateScreeningTable < ActiveRecord::Migration[5.0]
  def change
  	
    create_table :screenings do |t|
    	t.belongs_to :movie_tables, index: true
    	t.belongs_to :theater_tables, index: true
    	t.datetime :ondate
    	t.boolean :first
    	t.boolean :Second
    	t.boolean :third
    	t.boolean :fourth
    	t.timestamps
    end
  end
end
