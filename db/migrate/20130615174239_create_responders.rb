class CreateResponders < ActiveRecord::Migration
  def change
    create_table :responders do |t|
      t.string :srcphone
      t.string :zip
      t.float :lat
      t.float :long
      t.float :radius
      t.string :active

      t.timestamps
    end
  end
end
