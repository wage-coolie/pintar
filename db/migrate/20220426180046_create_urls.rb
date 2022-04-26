class CreateUrls < ActiveRecord::Migration[6.1]
  def change
    create_table :urls do |t|
      t.string :url, null: false, unique: true
      t.string :short_code, null: false, unique: true
      t.integer :redirect_count, default: 0

      t.timestamps
    end
  end
end
