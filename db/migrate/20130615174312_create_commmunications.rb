class CreateCommmunications < ActiveRecord::Migration
  def change
    create_table :commmunications do |t|
      t.integer :flare_id
      t.integer :responder_id

      t.timestamps
    end
  end
end
