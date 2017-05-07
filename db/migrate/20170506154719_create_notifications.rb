class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.references :sender, index: true, foreign_key: true
      t.references :receiver, index: true, foreign_key: true
      t.string :type
      t.references :message, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
