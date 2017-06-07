class CreateFares < ActiveRecord::Migration[5.0]
  def change
    create_table :fares do |t|
      t.string :origin
      t.string :destination

      t.timestamps

    end
  end
end
