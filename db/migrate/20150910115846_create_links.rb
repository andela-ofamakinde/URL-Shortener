class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.text :long_url
      t.string :short_url
      t.integer :http_status
      t.belongs_to :user
      t.timestamps null: false
    end
  end
end
