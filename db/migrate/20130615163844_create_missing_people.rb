class CreateMissingPeople < ActiveRecord::Migration
  def change
    create_table :missing_people do |t|
      t.string :name
      t.string :contact_name
      t.string :contact_number
      t.text :description
      t.boolean :found

      t.timestamps
    end
  end
end
