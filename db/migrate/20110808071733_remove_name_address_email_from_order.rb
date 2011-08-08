class RemoveNameAddressEmailFromOrder < ActiveRecord::Migration
  def self.up
    remove_column :orders, :name
    remove_column :orders, :address
    remove_column :orders, :email
  end

  def self.down
    add_column :orders, :name, :string
    add_column :orders, :address, :text
    add_column :orders, :email, :string
  end
end
