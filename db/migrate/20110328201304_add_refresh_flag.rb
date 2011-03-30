class AddRefreshFlag < ActiveRecord::Migration
  def self.up
    add_column :images, :refresh, :boolean, :default => 0
  end

  def self.down
    remove_column :images, :refresh
  end
end
