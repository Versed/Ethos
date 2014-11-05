class User < ActiveRecord::Base
  has_many :ideaboards
  has_many :user_friendships
  has_many :friends, -> { where(user_friendships: { state: 'accepted' }) },
           through: :user_friendships

  has_many :pending_user_friendships, -> { where(pending_user_friendships: { state: 'pending' }) },
           class_name: 'UserFriendship',
           foreign_key: :user_id

  has_many :pending_friends, through: :pending_user_friendships, source: :friend

  has_many :requested_user_friendships, -> { where(requested_user_friendships: { state: 'requested' }) },
           class_name: 'UserFriendship',
           foreign_key: :user_id

  has_many :requested_friends, through: :requested_user_friendships, source: :friend

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
