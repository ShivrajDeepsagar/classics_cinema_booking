class ChangeColumnNameInScreenings < ActiveRecord::Migration[5.0]
  def change
  	rename_column :screenings, :Second, :second  
  end
end
