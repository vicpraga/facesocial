class ChangeAdminUser < ActiveRecord::Migration
  def change
  	change_column :users, :admin, :boolean, :default => false
  	add_column :notifications, :visto, :boolean, :default => false
  end
end
