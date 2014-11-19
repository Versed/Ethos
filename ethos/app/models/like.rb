class Like < ActiveRecord::Base
  belongs_to :user
  belongs_to :ideaboard
  validates_uniqueness_of :user_id, :scope => :ideaboard_id
end
