class Message < ApplicationRecord
  belongs_to :user
  belongs_to :conversation, counter_cache: true

  #validations
  validates :content, presence: true
  
  #callbacks
  after_commit 
  
  def notify_new_message_presence
    conversation.new_message_presence = true
    save
  end

end
