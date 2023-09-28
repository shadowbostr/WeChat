class AddColumnMessagesCountToConversations < ActiveRecord::Migration[6.1]
  def change
    add_column :conversations, :messages_count, :integer
  end
end
