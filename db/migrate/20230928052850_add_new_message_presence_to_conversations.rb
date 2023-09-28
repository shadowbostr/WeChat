class AddNewMessagePresenceToConversations < ActiveRecord::Migration[6.1]
  def change
    add_column :conversations, :new_message_presence, :boolean, default: false
  end
end
