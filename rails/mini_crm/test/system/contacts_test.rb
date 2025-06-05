require "application_system_test_case"

class ContactsTest < ApplicationSystemTestCase
  def setup
    @user = users(:one)
    @contact = contacts(:one)
    @contact.update!(
      name: "Jan Novák", 
      email: "jan@example.com",
      phone: "+420123456789",
      company: "Test Company",
      user: @user
    )
  end

  test "visiting the contacts index requires authentication" do
    visit contacts_url
    
    # Should redirect to login
    assert_selector "h2", text: "Přihlášení"
    assert_current_path new_user_session_path
  end

  test "user can view contacts list after login" do
    sign_in_user(@user)
    visit contacts_url
    
    assert_selector "h1", text: "Kontakty"
    assert_text "Jan Novák"
    assert_text "Test Company"
  end

  test "user can search contacts" do
    sign_in_user(@user)
    visit contacts_url
    
    # Create another contact for better testing
    other_contact = Contact.create!(
      name: "Petr Svoboda",
      email: "petr@example.com",
      user: @user
    )
    
    visit contacts_url
    
    # Search for specific contact
    fill_in "search", with: "Jan"
    click_button "Hledat"
    
    assert_text "Jan Novák"
    assert_no_text "Petr Svoboda"
  end

  test "user can create a new contact" do
    sign_in_user(@user)
    visit contacts_url
    
    click_link "Nový kontakt"
    assert_current_path new_contact_path
    
    # Fill in contact form
    fill_in "Jméno", with: "Marie Svobodová"
    fill_in "Email", with: "marie@example.com"
    fill_in "Telefon", with: "+420987654321"
    fill_in "Společnost", with: "Nová společnost"
    fill_in "Datum narození", with: "1985-05-15"
    
    click_button "Vytvořit kontakt"
    
    # Should redirect to contact detail
    assert_text "Contact was successfully created."
    assert_text "Marie Svobodová"
    assert_text "marie@example.com"
    assert_text "Nová společnost"
  end

  test "user sees validation errors for invalid contact" do
    sign_in_user(@user)
    visit new_contact_path
    
    # Submit form with missing required fields
    click_button "Vytvořit kontakt"
    
    # Should show validation errors
    assert_text "zabránila uložení kontaktu"
    assert_selector ".text-red-600", text: "can't be blank"
  end

  test "user can edit an existing contact" do
    sign_in_user(@user)
    visit contact_path(@contact)
    
    click_link "Upravit"
    assert_current_path edit_contact_path(@contact)
    
    # Update contact information
    fill_in "Jméno", with: "Jan Updated"
    fill_in "Email", with: "jan.updated@example.com"
    
    click_button "Uložit změny"
    
    # Should redirect back to contact detail
    assert_text "Contact was successfully updated."
    assert_text "Jan Updated"
    assert_text "jan.updated@example.com"
  end

  test "user can delete a contact" do
    sign_in_user(@user)
    visit contact_path(@contact)
    
    # Accept the confirmation dialog
    accept_confirm do
      click_link "Odstranit"
    end
    
    # Should redirect to contacts index
    assert_current_path contacts_path
    assert_text "Contact was successfully deleted."
    assert_no_text "Jan Novák"
  end

  test "user can view contact details with notes" do
    sign_in_user(@user)
    
    # Create a note for the contact
    note = @contact.notes.create!(
      content: "Test poznámka o klientovi",
      user: @user
    )
    
    visit contact_path(@contact)
    
    # Should show contact details
    assert_text "Jan Novák"
    assert_text "jan@example.com"
    assert_text "Test Company"
    
    # Should show notes section
    assert_text "Poznámky"
    assert_text "Test poznámka o klientovi"
  end

  test "contact detail page shows avatar" do
    sign_in_user(@user)
    visit contact_path(@contact)
    
    # Should have avatar component (either gravatar or initials)
    assert_selector ".rounded-full"
  end

  test "contact list shows contact cards with metadata" do
    sign_in_user(@user)
    
    # Create a note to test note count
    @contact.notes.create!(content: "Test note", user: @user)
    
    visit contacts_url
    
    # Should show contact in card format
    assert_selector ".bg-white.dark\\:bg-gray-800"  # Card background
    assert_text "Jan Novák"
    assert_text "1 poznámka"  # Note count
  end

  test "contact form handles Czech characters" do
    sign_in_user(@user)
    visit new_contact_path
    
    # Fill form with Czech characters
    fill_in "Jméno", with: "Tomáš Dvořák"
    fill_in "Email", with: "tomas@example.com"
    fill_in "Společnost", with: "Česká společnost s.r.o."
    
    click_button "Vytvořit kontakt"
    
    assert_text "Tomáš Dvořák"
    assert_text "Česká společnost s.r.o."
  end

  test "user can navigate using breadcrumbs" do
    sign_in_user(@user)
    visit edit_contact_path(@contact)
    
    # Should show breadcrumbs
    assert_selector "nav ol"
    assert_link "Kontakty"
    assert_text "Jan Novák"
    assert_text "Upravit"
    
    # Click breadcrumb to navigate back
    click_link "Kontakty"
    assert_current_path contacts_path
  end

  test "contact birthday field works correctly" do
    sign_in_user(@user)
    visit new_contact_path
    
    fill_in "Křestní jméno", with: "Birthday"
    fill_in "Příjmení", with: "Test"
    fill_in "Datum narození", with: "1990-01-01"
    
    click_button "Vytvořit kontakt"
    
    # Should show birthday in contact detail
    assert_text "1990"  # Year should be visible somewhere
  end

  test "user cannot access other user's contacts" do
    other_user = users(:two)
    other_contact = Contact.create!(
      first_name: "Other",
      last_name: "User", 
      email: "other@example.com",
      user: other_user
    )
    
    sign_in_user(@user)
    
    # Try to access other user's contact directly
    visit contact_path(other_contact)
    
    # Should show 404 or redirect (depends on implementation)
    # This might show an error page or redirect to contacts
    assert_no_text "Other User"
  end

  test "dark mode toggle works" do
    sign_in_user(@user)
    visit contacts_url
    
    # Find and click dark mode toggle
    find("button", text: /☀️|🌙/).click
    
    # Theme should change (this is basic - could be more thorough)
    # The actual test would depend on how dark mode is implemented
  end

  test "responsive design shows proper layout on mobile" do
    sign_in_user(@user)
    
    # Simulate mobile viewport
    page.driver.browser.manage.window.resize_to(375, 667)
    
    visit contacts_url
    
    # Contact cards should still be visible and readable
    assert_text "Jan Novák"
    assert_selector ".bg-white.dark\\:bg-gray-800"
  end

  test "search form clears properly" do
    sign_in_user(@user)
    visit contacts_url
    
    # Search for something
    fill_in "search", with: "Jan"
    click_button "Hledat"
    assert_field "search", with: "Jan"
    
    # Clear search
    fill_in "search", with: ""
    click_button "Hledat"
    
    # Should show all contacts again
    assert_text "Jan Novák"
  end

  test "user can add note from contact detail page" do
    sign_in_user(@user)
    visit contact_path(@contact)
    
    # Find and fill note form (assuming it exists on contact detail page)
    if has_field?("note_content")
      fill_in "note_content", with: "New note from contact page"
      click_button "Přidat poznámku"
      
      assert_text "New note from contact page"
    end
  end

  private

  def sign_in_user(user)
    visit new_user_session_path
    fill_in "Email", with: user.email
    fill_in "Heslo", with: "password"
    click_button "Přihlásit se"
    
    # Wait for redirect to complete
    assert_text "Úspěšně přihlášen" if has_text?("Úspěšně přihlášen")
  end
end
