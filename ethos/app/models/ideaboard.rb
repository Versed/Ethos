class Ideaboard < ActiveRecord::Base
  belongs_to :user
  belongs_to :document
  has_many :albums
  has_many :pictures
  has_many :collaborations
  has_many :likes
  has_many :tags

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
