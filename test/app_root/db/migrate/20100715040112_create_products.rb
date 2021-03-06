class CreateProducts < ActiveRecord::Migration
  def self.up
    create_table :products do |t|
      t.column :name,       :string
      t.column :serial,       :string
      t.column :created_at, :datetime
      t.column :updated_at, :datetime
    end
  end

  def self.down
    drop_table :products
  end
end
