class Collaboration < ActiveRecord::Base
  belongs_to :ideaboard
  belongs_to :user

  state_machine :state, initial: :pending do
    state :requested

    event :accept do
      transition any => :accepted
    end
  end

  def self.request(user, ideaboard)
    transaction do
      collaboration = create(user: user, ideaboard: ideaboard, state: 'requested')
      collaboration
    end
  end
end
