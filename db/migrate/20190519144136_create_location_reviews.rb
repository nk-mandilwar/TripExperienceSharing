class CreateLocationReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :location_reviews do |t|
      t.integer :rating
      t.text :feedback
      t.references :user, index: true, foreign_key: true
      t.references :visited_location, index: true, foreign_key: true

      t.timestamps
    end
  end
end
