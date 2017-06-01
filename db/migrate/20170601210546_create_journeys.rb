class CreateJourneys < ActiveRecord::Migration[5.0]
  def change
    create_table :journeys do |t|
      t.string :origin
      t.string :destination
      t.integer :capacity
      t.datetime :date
      t.string :price
      t.integer :organizer_id

      t.timestamps

    end
  end
end
