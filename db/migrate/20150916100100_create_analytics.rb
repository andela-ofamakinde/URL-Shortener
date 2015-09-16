class CreateAnalytics < ActiveRecord::Migration
  def change
    create_table :analytics do |t|
      t.integer :visits
      t.integer :unique_visits
      t.references :link, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
