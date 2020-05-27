class CreateSongs < ActiveRecord::Migration[6.0]
  def up
    create_table :songs do |t|
      t.references :artists, null: false
      t.string :title
      t.integer :length
      t.integer :filesize

      t.timestamps
    end
  end

  def down
    drop_table :songs
  end
end
