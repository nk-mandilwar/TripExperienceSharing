class CreateRatings < ActiveRecord::Migration[5.2]
  def change
    create_table :ratings do |t|
      t.references :user, index: true, foreign_key: true
      t.integer :points, default: 0

      t.timestamps
    end
  end
end
