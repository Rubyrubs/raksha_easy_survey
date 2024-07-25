class CreateComponents < ActiveRecord::Migration[6.0]
  def change
    create_table :components do |t|
      t.references :survey, null: false, foreign_key: true
      t.string :component_type
      t.text :content
      t.integer :position

      t.timestamps
    end
  end
end
