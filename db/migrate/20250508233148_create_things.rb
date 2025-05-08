class CreateThings < ActiveRecord::Migration[7.2]

  def change
    create_enum :eee_enum, %w[one two three four five six seven eight nine ten]

    create_table :things do |t|
      t.integer :person_id
      t.boolean :bbb
      t.date :ccc
      t.datetime :ddd
      t.enum :eee, enum_type: :eee_enum
      t.float :fff
      t.integer :iii
      t.string :sss
      t.text :ttt
      t.time :mmm

      t.timestamps
    end
  end
end
