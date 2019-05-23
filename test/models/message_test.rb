require 'test_helper'

class MessageTest < ActiveSupport::TestCase
  #
  # Validations
  #

  test "title presence" do
    message = Message.new
    assert message.invalid?
    assert message.errors[:title].present?
  end

  test "content presence" do
    message = Message.new
    assert message.invalid?
    assert message.errors[:content].present?
  end

  #
  # State machine
  # 
  test "initial state" do
    message = Message.create(title: '1', content: '2')
    assert message.unread?
  end

  test "reading a message" do
    message = messages(:one)

    assert message.unread?
    message.read

    assert message.read?
    assert message.read_at.present?
  end

  test "archive all messages" do
    message = messages(:one)
    message_two = messages(:two)
    message_three = messages(:three)

    Message.archive_all
    assert message.reload.archived?
    assert message_two.reload.archived?
    assert message_three.reload.archived?
  end
end
