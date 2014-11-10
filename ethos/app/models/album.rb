class Album < ActiveRecord::Base
  belongs_to :ideaboard
  has_many :pictures
end
