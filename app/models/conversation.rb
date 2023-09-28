class Conversation < ApplicationRecord

  # Associations
  # ============
   # Conversation may have many users (in group chat)
   # Conversation might belongs to two or more users
   has_and_belongs_to_many :users, join_table: 'conversations_users'
   # Single conversation can hold many messages
   has_many :messages  # the conversation could contain many messages


  def sender_messages_count(sender)
    self.messages.where(user_id: sender.id).count
  end

end
