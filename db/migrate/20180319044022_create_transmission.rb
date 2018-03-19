class CreateTransmission < ActiveRecord::Migration[5.1]
  def change
    create_table :transmissions do |t|
      t.string :name,         null: false
      t.string :description

      t.integer :status,      null: false, default: 0

      t.datetime :started_at
      t.datetime :ended_at

      t.timestamps
    end

    add_index :transmissions, :status
  end
end
