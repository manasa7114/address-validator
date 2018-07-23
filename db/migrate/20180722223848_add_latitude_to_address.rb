class AddLatitudeToAddress < ActiveRecord::Migration[5.1]
  def change
    add_column :addresses, :latitude, :float
  end
end
