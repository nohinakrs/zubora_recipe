class CreateRecipes < ActiveRecord::Migration[6.1]
  def change
    create_table :recipes do |t|
      t.string  :recipe_name
      t.text    :recipe
      t.integer :user_id
      t.timestamps
    end
  end
end
