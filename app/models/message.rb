class Message < ApplicationRecord
  belongs_to :user
  belongs_to :conversation, counter_cache: true

  #validations
  validates :content, presence: true

end
