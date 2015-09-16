class CreateUniqueVisitors < ActiveRecord::Migration
  def change
    create_table :unique_visitors do |t|
      t.string :visitor_ip
      t.string :browser
      t.string :browser_version
      t.string :platform
      t.string :country
      t.references :analytic, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
