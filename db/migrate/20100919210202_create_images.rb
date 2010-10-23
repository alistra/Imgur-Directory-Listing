class CreateImages < ActiveRecord::Migration
  def self.up
    create_table :images do |t|
      t.string :name
      t.string :imglink
      t.string :dellink
      t.string :large_thumb
      t.string :small_thumb

      t.timestamps
    end
  end

  def self.down
    drop_table :images
  end
end
