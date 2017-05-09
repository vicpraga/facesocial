class CreateFriends < ActiveRecord::Migration
  def change
    create_table :friends do |t|
      t.references :userA, index: true, foreign_key: true
      t.references :userB, index: true, foreign_key: true
      t.boolean :estado, :default => false

      t.timestamps null: false
    end
  end
end
