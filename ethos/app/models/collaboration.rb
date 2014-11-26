class Collaboration < ActiveRecord::Base
  belongs_to :ideaboard
  belongs_to :user

  state_machine :state, initial: :pending do
    state :requested
    state :blocked

    event :accept do
      transition any => :accepted
    end

    event :block do
      transition any => :blocked
    end
  end

  def self.request(user, ideaboard)
    transaction do
      collaboration = create(user: user, ideaboard: ideaboard, state: 'requested')
      collaboration
    end
  end

  def accept_collaboration!
    self.update_attribute(:state, 'accepted')
  end

  def block!
    self.update_attribute(:state, 'blocked')
  end
end
