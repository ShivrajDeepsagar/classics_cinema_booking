class CreateReservations < ActiveRecord::Migration[5.0]
  def change
    create_table :reservations do |t|
      t.belongs_to :screenings, index: true
      t.belongs_to :users, index: true
      t.boolean :reserved
      t.boolean :paid
      t.boolean :active
      t.integer :show_num
      t.timestamps
    end
  end
end
