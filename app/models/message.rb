class Message < ActiveRecord::Base

  validates :title, :content, presence: true

  state_machine :state, initial: :unread do

    event :read do
      transition unread: :read 
    end

    event :archive do
      transition any => :archived
    end

    after_transition to: :read do |message|
      message.read_at = Time.current
    end

    after_transition to: :archive do |message|
      message.archived_at = Time.current
    end
  end

  def self.archive_all
    messages = Message.all
    messages.each do |message|
      message.archive
    end
  end
end
