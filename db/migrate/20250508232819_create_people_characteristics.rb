class CreatePeopleCharacteristics < ActiveRecord::Migration[7.2]
  def change
    create_table :people_characteristics do |t|
      t.integer :person_id
      t.integer :characteristic_id

      t.timestamps
    end
  end
end
