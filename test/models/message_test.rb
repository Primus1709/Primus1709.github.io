require "test_helper"

class MessageTest < ActiveSupport::TestCase
  test "valid with a name, email and message" do
    assert Message.new(name: "Ada", email: "ada@example.com", body: "Hello there, nice site.").valid?
  end

  test "rejects a bad email address" do
    message = Message.new(name: "Ada", email: "not-an-email", body: "Hello there, nice site.")
    assert_not message.valid?
    assert message.errors[:email].any?
  end

  test "rejects very short messages" do
    message = Message.new(name: "Ada", email: "ada@example.com", body: "hi")
    assert_not message.valid?
  end

  test "cleans up the email address" do
    message = Message.new(email: "  Ada@Example.COM ")
    assert_equal "ada@example.com", message.email
  end

  test "mark_read! sets read_at once" do
    message = messages(:recruiter)
    assert_not message.read?

    message.mark_read!
    first_read = message.read_at
    assert message.read?

    message.mark_read!
    assert_equal first_read, message.read_at
  end
end
