class AddPositionsToComponents < ActiveRecord::Migration[6.0]
  def change
    add_column :components, :position_x, :string
    add_column :components, :position_y, :string
  end
end
