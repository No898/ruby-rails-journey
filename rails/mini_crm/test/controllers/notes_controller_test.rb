require "test_helper"

class NotesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @note = notes(:one)
    @user = users(:one)
    sign_in @user
  end

  test "should get index" do
    get notes_url
    assert_response :success
  end

  test "should get new" do
    get new_note_url
    assert_response :success
  end

  test "should create note" do
    assert_difference("Note.count") do
      post notes_url, params: { note: { contact_id: @note.contact_id, content: "New test note content" } }
    end

    assert_redirected_to note_url(Note.first)  # first because of desc order
  end

  test "should show note" do
    get note_url(@note)
    assert_response :success
  end

  test "should get edit" do
    get edit_note_url(@note)
    assert_response :success
  end

  test "should update note" do
    patch note_url(@note), params: { note: { contact_id: @note.contact_id, content: @note.content } }
    assert_redirected_to note_url(@note)
  end

  test "should destroy note" do
    assert_difference("Note.count", -1) do
      delete note_url(@note)
    end

    assert_redirected_to notes_url
  end

  private

  def sign_in(user)
    post user_session_path, params: {
      user: {
        email: user.email,
        password: "password"
      }
    }
  end
end
