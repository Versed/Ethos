class User < ActiveRecord::Base
  has_many :ideaboards
  has_many :user_friendships
  has_many :friends, through: :user_friendships
           conditions: { user_friendships: { state: 'accepted' }}

  has_many :pending_user_friendships, class_name: 'UserFriendship',
           foreign_key: :user_id,
           conditions: { state: 'pending' }

  has_many :pending_friends, through: :pending_user_friendships, source: :friend

  validates :first_name, presence: true
  validates :last_name, presence: true

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def to_param
    username
  end

  def full_name
    first_name + " " + last_name
  end

  def avatar
    stripped_email = email.strip
    downcase_email = stripped_email.downcase
    hash = Digest::MD5.hexdigest(downcase_email)

    "http://gravatar.com/avatar/#{hash}"
  end
end
