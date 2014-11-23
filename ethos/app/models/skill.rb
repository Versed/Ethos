class Skill < ActiveRecord::Base
  belongs_to :targetable, polymorphic: true
end
