class ImageUrl < ActiveRecord::Migration[5.0]
  def change
    add_column :movies, :image_url, :string, default: "none"
  end
end
