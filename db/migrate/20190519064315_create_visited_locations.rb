class CreateVisitedLocations < ActiveRecord::Migration[5.2]
  def change
    create_table :visited_locations do |t|
      t.string :city
      t.decimal :latitude
      t.decimal :longitude
      t.references :user, index: true, foreign_key: true

      t.timestamps
    end
  end
end
