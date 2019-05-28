class Message < ActiveRecord::Base
  validates :title, :content, presence: true

  state_machine :state, initial: :unread do

    event :read do
      transition unread: :read 
    end

    event :archive do
      transition any => :archived
    end

    before_transition :on => :read, :do => :read_message
    before_transition :on => :archive, :do => :archive_message
  end

  def self.archive_all
    Message.find_each do |message|
      message.archive
    end
  end

  def read_message
    self.read_at = Time.now
  end

  def archive_message
    self.archived_at = Time.now
  end
end
