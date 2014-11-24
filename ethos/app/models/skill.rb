class Skill < ActiveRecord::Base
  belongs_to :skillable, polymorphic: true

  validates :name, presence: true, length: { minimum: 3 }
  validates_uniqueness_of :targetable_id, :scope => :name
end
