class Tag < ActiveRecord::Base
  belongs_to :ideaboard

  validates :name, presence: true, length: { minimum: 3 }
  validates_uniqueness_of :ideaboard_id, :scope => :name
end
