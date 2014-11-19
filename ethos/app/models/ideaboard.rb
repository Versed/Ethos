class Ideaboard < ActiveRecord::Base
  belongs_to :user
  belongs_to :document
  has_many :albums
  has_many :pictures
  has_many :collaborations
  has_many :likes

  accepts_nested_attributes_for :document

  validates :title, presence: true, length: { minimum: 5 }
  validates :user, presence: true
end
