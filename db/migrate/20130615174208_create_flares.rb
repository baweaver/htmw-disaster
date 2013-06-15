class CreateFlares < ActiveRecord::Migration
  def change
    create_table :flares do |t|
      t.string :srcphone
      t.integer :zip
      t.string :location
      t.float :lat
      t.float :long
      t.string :category
      t.text :description
      t.boolean :active

      t.timestamps
    end
  end
end
