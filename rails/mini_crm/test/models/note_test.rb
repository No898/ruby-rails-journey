require "test_helper"

class NoteTest < ActiveSupport::TestCase
  setup do
    Note.delete_all
    Contact.delete_all
    User.delete_all
  end

  test "creating a note updates contact last_contacted_at" do
    user = User.create!(email: "test@example.com", password: "password")
    contact = Contact.new(name: "Test", email: "test@contact.com", company: "TestCo")
    contact.user = user
    contact.save!

    assert_nil contact.last_contacted_at

    Note.create!(user: user, contact: contact, content: "Callback test")

    assert_in_delta Time.current, contact.reload.last_contacted_at, 2.seconds
  end
end
