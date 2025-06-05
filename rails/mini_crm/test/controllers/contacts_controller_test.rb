require "test_helper"

class ContactsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:one)
    @contact = contacts(:one)
    @contact.update!(user: @user)
    @other_user = users(:two)
  end

  # Authentication tests
  test "should redirect to login when not authenticated" do
    get contacts_url
    assert_redirected_to new_user_session_path
  end

  test "should require authentication for all actions" do
    actions = [
      [:get, contacts_url],
      [:get, new_contact_url],
      [:get, contact_url(@contact)],
      [:get, edit_contact_url(@contact)],
      [:post, contacts_url, { params: { contact: { name: "Test" } } }],
      [:patch, contact_url(@contact), { params: { contact: { name: "Updated" } } }],
      [:delete, contact_url(@contact)]
    ]

    actions.each do |method, url, options|
      options ||= {}
      send(method, url, **options)
      assert_redirected_to new_user_session_path, "#{method.upcase} #{url} should require authentication"
    end
  end

  # Index action tests
  test "should get index when authenticated" do
    sign_in @user
    get contacts_url
    assert_response :success
    assert_select "h1", text: /Kontakty/
  end

  test "should only show user's own contacts" do
    sign_in @user
    other_contact = Contact.create!(
      name: "Other User",
      email: "other@example.com",
      user: @other_user
    )

    get contacts_url
    assert_response :success
    
    # Should include user's contact
    assert_includes assigns(:contacts), @contact
    # Should not include other user's contact
    assert_not_includes assigns(:contacts), other_contact
  end

  test "should search contacts" do
    sign_in @user
    @contact.update!(name: "Searchable Contact")
    
    get contacts_url, params: { query: "Searchable" }
    assert_response :success
    assert_includes assigns(:contacts), @contact
  end

  test "should handle empty search" do
    sign_in @user
    get contacts_url, params: { query: "" }
    assert_response :success
    assert_includes assigns(:contacts), @contact
  end

  test "should return no results for non-matching search" do
    sign_in @user
    get contacts_url, params: { query: "NonExistentContact" }
    assert_response :success
    assert_empty assigns(:contacts)
  end

  # Show action tests
  test "should show contact when authenticated and authorized" do
    sign_in @user
    get contact_url(@contact)
    assert_response :success
    assert_equal @contact, assigns(:contact)
  end

  test "should not show other user's contact" do
    sign_in @user
    other_contact = Contact.create!(
      name: "Other Contact",
      user: @other_user
    )

    get contact_url(other_contact)
    assert_response :not_found
  end

  test "should load contact notes on show" do
    sign_in @user
    note = @contact.notes.create!(content: "Test note", user: @user)
    
    get contact_url(@contact)
    assert_response :success
    assert_includes assigns(:notes), note
  end

  # New action tests
  test "should get new when authenticated" do
    sign_in @user
    get new_contact_url
    assert_response :success
    assert_not_nil assigns(:contact)
    assert assigns(:contact).new_record?
  end

  # Create action tests
  test "should create contact with valid params" do
    sign_in @user
    
    assert_difference("Contact.count") do
      post contacts_url, params: {
        contact: {
          name: "Jan Novák",
          email: "jan@example.com",
          phone: "+420123456789",
          company: "Test Company"
        }
      }
    end

    contact = Contact.last
    assert_equal @user, contact.user
    assert_redirected_to contact_url(contact)
    assert_equal "Contact was successfully created.", flash[:notice]
  end

  test "should not create contact with invalid params" do
    sign_in @user
    
    assert_no_difference("Contact.count") do
      post contacts_url, params: {
        contact: {
          name: "",  # Invalid - required
          email: "invalid-email"  # Invalid format
        }
      }
    end

    assert_response :unprocessable_entity
    assert_not_nil assigns(:contact)
    assert assigns(:contact).errors.any?
  end

  test "should validate email format on create" do
    sign_in @user
    
    post contacts_url, params: {
      contact: {
        name: "Test User",
        email: "invalid-email"
      }
    }

    assert_response :unprocessable_entity
    assert assigns(:contact).errors[:email].any?
  end

  # Edit action tests
  test "should get edit when authorized" do
    sign_in @user
    get edit_contact_url(@contact)
    assert_response :success
    assert_equal @contact, assigns(:contact)
  end

  test "should not edit other user's contact" do
    sign_in @user
    other_contact = Contact.create!(
      name: "Other Contact",
      user: @other_user
    )

    get edit_contact_url(other_contact)
    assert_response :not_found
  end

  # Update action tests
  test "should update contact with valid params" do
    sign_in @user
    
    patch contact_url(@contact), params: {
      contact: {
        name: "Updated Name",
        email: "updated@example.com"
      }
    }

    @contact.reload
    assert_equal "Updated Name", @contact.name
    assert_equal "updated@example.com", @contact.email
    assert_redirected_to contact_url(@contact)
    assert_equal "Contact was successfully updated.", flash[:notice]
  end

  test "should not update contact with invalid params" do
    sign_in @user
    original_name = @contact.name
    
    patch contact_url(@contact), params: {
      contact: {
        name: "",  # Invalid
        email: "invalid-email"
      }
    }

    assert_response :unprocessable_entity
    @contact.reload
    assert_equal original_name, @contact.name  # Should not change
    assert assigns(:contact).errors.any?
  end

  test "should not update other user's contact" do
    sign_in @user
    other_contact = Contact.create!(
      name: "Other Contact",
      user: @other_user
    )

    patch contact_url(other_contact), params: {
      contact: { name: "Hacked" }
    }
    assert_response :not_found
  end

  # Destroy action tests
  test "should destroy contact when authorized" do
    sign_in @user
    
    assert_difference("Contact.count", -1) do
      delete contact_url(@contact)
    end

    assert_redirected_to contacts_url
    assert_equal "Contact was successfully deleted.", flash[:notice]
  end

  test "should destroy associated notes when contact is destroyed" do
    sign_in @user
    note = @contact.notes.create!(content: "Test note", user: @user)
    initial_note_count = @contact.notes.count
    
    assert_difference("Contact.count", -1) do
      assert_difference("Note.count", -initial_note_count) do
        delete contact_url(@contact)
      end
    end
  end

  test "should not destroy other user's contact" do
    sign_in @user
    other_contact = Contact.create!(
      name: "Other Contact",
      user: @other_user
    )

    delete contact_url(other_contact)
    assert_response :not_found
  end

  # Edge cases and error handling
  test "should handle non-existent contact gracefully" do
    sign_in @user
    
    get contact_url(id: 999999)
    assert_response :not_found
  end

  test "should assign current user to new contact" do
    sign_in @user
    
    post contacts_url, params: {
      contact: {
        name: "Test User",
        email: "test@example.com"
      }
    }

    contact = Contact.last
    assert_equal @user, contact.user
  end

  test "should handle birthday field" do
    sign_in @user
    birthday = Date.parse("1990-01-01")
    
    post contacts_url, params: {
      contact: {
        name: "Birthday Test",
        birthday: birthday
      }
    }

    contact = Contact.last
    assert_equal birthday, contact.birthday
  end

  test "should not accept future birthday" do
    sign_in @user
    
    post contacts_url, params: {
      contact: {
        name: "Future Birthday",
        birthday: Date.tomorrow
      }
    }

    assert_response :unprocessable_entity
    assert assigns(:contact).errors[:birthday].any?
  end

  # JSON responses
  test "should return JSON for index" do
    sign_in @user
    get contacts_url, as: :json
    assert_response :success
    assert_equal "application/json", response.media_type
  end

  test "should return JSON for show" do
    sign_in @user
    get contact_url(@contact), as: :json
    assert_response :success
    assert_equal "application/json", response.media_type
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
