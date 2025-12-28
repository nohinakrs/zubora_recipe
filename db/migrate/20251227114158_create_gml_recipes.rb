class CreateGmlRecipes < ActiveRecord::Migration[6.1]
  def change
    create_table :gml_recipes do |t|
      t.references :recipe, null: false, foreign_key: true
      t.string :material, null: false
      t.float :number, null: false, default: 0
      t.string :unit, null: false

      t.timestamps
    end
  end
end
