class AddRootIdAndAncestorIdToPosts < ActiveRecord::Migration
  def self.up
    add_column :posts, :root_id, :integer
    add_column :posts, :ancestor_id, :integer
  end

  def self.down
    remove_column :posts, :ancestor_id
    remove_column :posts, :root_id
  end
end
