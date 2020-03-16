class CreateSeats < ActiveRecord::Migration[5.0]
  def change
    create_table :seats do |t|
      t.belongs_to :screening, index: true
      t.timestamps
    end
  end
end
