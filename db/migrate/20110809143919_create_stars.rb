class CreateStars < ActiveRecord::Migration
  def self.up
    create_table :stars do |t|
      t.integer :product_id
      t.integer :user_id
      t.integer :grade

      t.timestamps
    end
  end

  def self.down
    drop_table :stars
  end
end
