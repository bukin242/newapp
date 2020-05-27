class CreateDownloads < ActiveRecord::Migration[6.0]
  def up
    create_table :downloads do |t|
      t.references :song, null: false
      t.timestamps
    end
  end

  def down
    drop_table :downloads
  end
end
