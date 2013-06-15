class CreateAssists < ActiveRecord::Migration
  def change
    create_table :assists do |t|
      t.integer :flare_id
      t.integer :responder_id
      t.boolean :active

      t.timestamps
    end
  end
end
