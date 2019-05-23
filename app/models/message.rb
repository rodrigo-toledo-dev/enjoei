class Message < ActiveRecord::Base

  after_update :update_status

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
      message.save
    end

    after_transition to: :archive do |message|
      message.archived_at = Time.current
      message.save
    end
  end

  def self.archive_all
    messages = Message.all
    messages.each do |message|
      message.archive
    end
  end
  

  def update_status
    message = self.reload
    if message.read? && message.read_at.blank?
      message.update_attribute(:read_at, Time.now)
    elsif message.archived? && message.archived_at.blank?
      message.update_attribute(:archived_at, Time.now)
    end
  end
end
