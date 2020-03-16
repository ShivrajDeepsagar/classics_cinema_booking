class CreateTableCoupons < ActiveRecord::Migration[5.0]
  def change
    create_table :coupons do |t|
      t.string :code
      t.integer :discount
      t.timestamps
    end
  end
end
