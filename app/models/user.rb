class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable,
         :rememberable, :validatable, :confirmable, :lockable


  # Associations
   has_and_belongs_to_many :conversations, join_table: 'conversations_users'
   has_many :messages
   has_one_attached :avatar

  # validations
  validates :username, presence: true, uniqueness: true, length: { in: 4..15 }
  validate :check_username_format

  #scopes
  scope :except_users, ->(user_ids){ where.not( id: user_ids) }
  scope :search_by_email, ->(email) { where('email LIKE ?', "%#{email}%") if email.present? }

  # callbacks
  after_commit :add_default_avatar, on: %i[create update]
  
  def check_username_format
    # To check username starts with an alphabet
    unless username[0].match?(/[A-Za-z]/)
      errors.add(:username, "should start with  alphabet")
    end
    # To check whether username  contains space
    return unless username.match?(/\s/)
    errors.add(:username, "should not contain whitespaces")
    
  end

  def avatar_thumbnail
    avatar.variant(resize_to_limit: [80,80])
  end

  private

  def add_default_avatar
    unless avatar.attached?
    avatar.attach(
      io: File.open( Rails.root.join('app', 'assets', 'images', 'default_avatar.PNG')),
      filename: 'default_avatar.PNG',
      content_type: 'image/PNG'
    )
    end
  end

end
