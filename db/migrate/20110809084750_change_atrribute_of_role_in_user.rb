class ChangeAtrributeOfRoleInUser < ActiveRecord::Migration
  def self.up
    remove_column :users, :role
    add_column :users, :role, :string, :default => 'Administrator'
  end

  def self.down
    remove_column :users, :role
    add_column :users, :role, :integer, :default => 1
  end
end
