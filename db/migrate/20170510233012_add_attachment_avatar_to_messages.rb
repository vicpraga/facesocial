class AddAttachmentAvatarToMessages < ActiveRecord::Migration
  def self.up
    change_table :messages do |t|
      t.attachment :avatar
    end
  end

  def self.down
    remove_attachment :messages, :avatar
  end
end
