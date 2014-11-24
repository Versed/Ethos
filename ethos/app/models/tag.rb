class Tag < ActiveRecord::Base
  belongs_to :tagable, polymorphic: true
  self.per_page = 50

  validates :name, presence: true, length: { minimum: 3 }
  validates_uniqueness_of :tagable_id, :scope => :name
end
