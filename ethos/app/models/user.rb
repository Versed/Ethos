class User < ActiveRecord::Base
  has_many :ideaboards
  has_many :activities
  has_many :user_friendships
  has_many :collaborations
  has_many :friends, -> { where(user_friendships: { state: "accepted" }) },
           through: :user_friendships

  has_many :pending_user_friendships, -> { where(user_friendships: { state: 'pending' }) },
           class_name: 'UserFriendship',
           foreign_key: :user_id

  has_many :pending_friends, through: :pending_user_friendships, source: :friend

  has_many :requested_user_friendships, -> { where(user_friendships: { state: 'requested' }) },
           class_name: 'UserFriendship',
           foreign_key: :user_id

  has_many :requested_friends, through: :requested_user_friendships, source: :friend

  has_many :blocked_user_friendships, -> { where(user_friendships: { state: 'blocked' }) },
           class_name: 'UserFriendship',
           foreign_key: :user_id

  has_many :blocked_friends, through: :blocked_user_friendships, source: :friend

  has_attached_file :avatar, styles: {
    large: "800x800>", medium: "300x200>", small: "260x180>", thumb: "80x80#"
  }

  validates_attachment_content_type :avatar, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]

  validates :first_name, presence: true
  validates :last_name, presence: true

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  after_create do
    subscribe_to_mailchimp
  end

  def self.get_gravatars
    all.each do |user|
      if !user.avatar?
        user.avatar = URI.parse(user.gravatar_url)
        user.save
        print "."
      end
    end
  end

  def to_param
    username
  end

  def to_s
    first_name
  end

  def full_name
    first_name + " " + last_name
  end

  def has_blocked?(user)
    blocked_friends.include?(user)
  end

  def gravatar_url
    stripped_email = email.strip
    downcase_email = stripped_email.downcase
    hash = Digest::MD5.hexdigest(downcase_email)

    "http://gravatar.com/avatar/#{hash}"
  end

  def create_activity(item, action)
    activity = activities.new
    activity.targetable = item
    activity.action = action
    activity.save
    activity
  end

  def subscribe_to_mailchimp testing=false
    return true if (Rails.env.test? && !testing)
    list_id = ENV['MAILCHIMP_LIST_ID']

    response = Rails.configuration.mailchimp.lists.subscribe({
      id: list_id,
      email: {email: email},
      double_optin: false,
    })
    response
  end
end
