require "test_helper"

class NoteTest < ActiveSupport::TestCase
  def setup
    @user = users(:one)
    @contact = contacts(:one)
    @contact.update!(user: @user)
    @note = Note.new(
      content: "Test poznámka o klientovi",
      user: @user,
      contact: @contact
    )
  end

  # Validations
  test "should be valid with valid attributes" do
    assert @note.valid?
  end

  test "should require content" do
    @note.content = nil
    assert_not @note.valid?
    assert_includes @note.errors[:content], "can't be blank"
  end

  test "should require content not to be empty" do
    @note.content = ""
    assert_not @note.valid?
    assert_includes @note.errors[:content], "can't be blank"
  end

  test "should require content not to be just whitespace" do
    @note.content = "   \n\t  "
    assert_not @note.valid?
    assert_includes @note.errors[:content], "can't be blank"
  end

  test "should require minimum content length" do
    @note.content = "a" * 2  # Too short
    assert_not @note.valid?
    assert_includes @note.errors[:content], "is too short (minimum is 3 characters)"
  end

  test "should accept minimum valid content length" do
    @note.content = "abc"  # Exactly minimum
    assert @note.valid?
  end

  test "should limit maximum content length" do
    @note.content = "a" * 1001  # Too long
    assert_not @note.valid?
    assert_includes @note.errors[:content], "is too long (maximum is 1000 characters)"
  end

  test "should accept maximum valid content length" do
    @note.content = "a" * 1000  # Exactly maximum
    assert @note.valid?
  end

  test "should require user" do
    @note.user = nil
    assert_not @note.valid?
    assert_includes @note.errors[:user], "must exist"
  end

  test "should require contact" do
    @note.contact = nil
    assert_not @note.valid?
    assert_includes @note.errors[:contact], "must exist"
  end

  # Associations
  test "should belong to user" do
    assert_respond_to @note, :user
    assert_kind_of User, @note.user
  end

  test "should belong to contact" do
    assert_respond_to @note, :contact
    assert_kind_of Contact, @note.contact
  end

  # Business Logic - Callback Testing
  test "creating a note updates contact last_contacted_at" do
    # Clear any existing last_contacted_at
    @contact.update!(last_contacted_at: nil)
    assert_nil @contact.last_contacted_at

    freeze_time = Time.current
    travel_to freeze_time do
      @note.save!
      @contact.reload
      assert_equal freeze_time.to_i, @contact.last_contacted_at.to_i
    end
  end

  test "updating a note does not change contact last_contacted_at" do
    @note.save!
    original_time = @contact.reload.last_contacted_at

    travel_to 1.hour.from_now do
      @note.update!(content: "Updated content")
      @contact.reload
      assert_equal original_time.to_i, @contact.last_contacted_at.to_i
    end
  end

  test "deleting a note does not change contact last_contacted_at" do
    @note.save!
    original_time = @contact.reload.last_contacted_at

    travel_to 1.hour.from_now do
      @note.destroy!
      @contact.reload
      assert_equal original_time.to_i, @contact.last_contacted_at.to_i
    end
  end

  # Scopes and Ordering
  test "should order notes by created_at desc by default" do
    # Create notes in sequence with time travel to ensure different timestamps
    travel_to 2.hours.ago do
      @older_note = Note.create!(
        content: "Older note",
        user: @user,
        contact: @contact
      )
    end
    
    travel_to 1.hour.ago do
      @newer_note = Note.create!(
        content: "Newer note", 
        user: @user,
        contact: @contact
      )
    end

    # Query only our new notes
    our_notes = [@older_note, @newer_note]
    ordered_notes = Note.where(id: our_notes.map(&:id)).limit(2)
    
    assert_equal @newer_note.id, ordered_notes.first.id
    assert_equal @older_note.id, ordered_notes.last.id
  end

  # Content Processing
  test "should strip whitespace from content" do
    @note.content = "  Content with spaces  \n"
    @note.save!
    assert_equal "Content with spaces", @note.content
  end

  test "should preserve internal whitespace in content" do
    @note.content = "Content\nwith\nmultiple\nlines"
    @note.save!
    assert_equal "Content\nwith\nmultiple\nlines", @note.content
  end

  # Authorization helpers (for testing in controllers)
  test "should identify note owner" do
    @note.save!
    assert @note.owned_by?(@user)
    
    other_user = User.create!(email: "other@example.com", password: "password")
    assert_not @note.owned_by?(other_user)
  end

  # Display helpers
  test "should truncate content for preview" do
    long_content = "a" * 200
    @note.content = long_content
    @note.save!
    
    preview = @note.content_preview(50)
    assert_equal 53, preview.length  # 50 chars + "..."
    assert preview.end_with?("...")
  end

  test "should not truncate short content for preview" do
    @note.content = "Short content"
    @note.save!
    
    preview = @note.content_preview(50)
    assert_equal "Short content", preview
  end

  # Edge cases
  test "should handle emoji in content" do
    @note.content = "Great meeting! 😊 👍 🎉"
    assert @note.valid?
    @note.save!
    assert_equal "Great meeting! 😊 👍 🎉", @note.content
  end

  test "should handle special characters in content" do
    @note.content = "Cena: 1,500 Kč (včetně DPH 21%)"
    assert @note.valid?
    @note.save!
    assert_equal "Cena: 1,500 Kč (včetně DPH 21%)", @note.content
  end

  # Performance considerations (placeholder for future implementation)
  # test "should not trigger N+1 queries when loading with associations" do
  #   @note.save!
  #   
  #   assert_queries(1) do
  #     Note.includes(:user, :contact).find(@note.id)
  #   end
  # end
end
