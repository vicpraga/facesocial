class ChangeColumnNotifications < ActiveRecord::Migration
  def change
  	remove_column :notifications, :type
  	add_column :notifications, :notificationType, :string
  	end
end
