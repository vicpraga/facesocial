class CreateShareds < ActiveRecord::Migration
  def change
    create_table :shareds do |t|
      t.references :user, index: true, foreign_key: true
      t.references :message, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
