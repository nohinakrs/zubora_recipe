class CreateRecipeRates < ActiveRecord::Migration[6.1]
  def change
    create_table :recipe_rates do |t|
      t.integer :user_id
      t.integer :recipe_id
      t.float :rate

      t.timestamps
    end
  end
end
