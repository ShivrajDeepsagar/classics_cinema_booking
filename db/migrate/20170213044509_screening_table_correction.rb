class ScreeningTableCorrection < ActiveRecord::Migration[5.0]
  def change
  	add_column :screenings,:first_seats,:integer,default: 100
  	add_column :screenings,:second_seats,:integer,default: 100
  	add_column :screenings,:third_seats,:integer,default: 100
  	add_column :screenings,:fourth_seats,:integer,default: 100
  	add_column :screenings,:cost,:integer, null: false
  end
end
