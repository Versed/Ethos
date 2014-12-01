class Ideaboard < ActiveRecord::Base
  belongs_to :user
  belongs_to :document
  has_many :albums
  has_many :pictures
  has_many :collaborations
  has_many :likes
  has_many :tags, -> { where( is_skill: false ) },
           as: :tagable, dependent: :destroy

  has_many :skills, -> { where( is_skill: true ) },
           foreign_key: :tagable_id, source: :tagable,
           class_name: 'Tag', source_type: 'Ideaboard', dependent: :destroy

  has_many :collaborators, -> { where(collaborations: { state: "accepted" }) },
           class_name: 'Collaboration', foreign_key: :ideaboard_id

  has_many :pending_collaborators, -> { where(collaborations: { state: "requested" }) },
           class_name: 'Collaboration', foreign_key: :ideaboard_id

  has_many :blocked_collaborators, -> { where(collaborations: { state: "blocked" }) },
           class_name: 'Collaboration', foreign_key: :ideaboard_id

  accepts_nested_attributes_for :document
  self.per_page = 30

  validates :title, presence: true, length: { minimum: 5 }
  validates :user, presence: true

  def self.filter_results(user, options={})
    options[:page] ||= 1
    options[:filter] ||= "all"

    case options[:filter]
    when "mine"
      collection = where("user_id in (?)", user.id)
    when "followed"
      collection = where("user_id in (?)", user.id)
    when "contributor"
      contribution_ids = user.collaborations.map(&:ideaboard_id)
      collection = where("id in (?)", contribution_ids)
    else
      contribution_ids = user.collaborations.map(&:ideaboard_id)
      collection = where("id in (?) or user_id in (?)", contribution_ids, user.id)
    end

    collection.page(options[:page]).order('created_at desc')
  end
end
