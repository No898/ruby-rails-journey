require "test_helper"

class ContactTest < ActiveSupport::TestCase
  def setup
    @user = users(:one)
    @contact = Contact.new(
      name: "Jan Novák",
      email: "jan@example.com",
      phone: "+420123456789",
      company: "Test Company",
      user: @user
    )
  end

  # Validations
  test "should be valid with valid attributes" do
    assert @contact.valid?
  end

  test "should require name" do
    @contact.name = nil
    assert_not @contact.valid?
    assert_includes @contact.errors[:name], "can't be blank"
  end

  test "should require user" do
    @contact.user = nil
    assert_not @contact.valid?
    assert_includes @contact.errors[:user], "must exist"
  end

  test "should validate email format" do
    invalid_emails = ["invalid", "@example.com", "test@", "test.com"]
    invalid_emails.each do |email|
      @contact.email = email
      assert_not @contact.valid?, "#{email} should be invalid"
    end

    valid_emails = ["test@example.com", "user.name@domain.co.uk", "123@test.org"]
    valid_emails.each do |email|
      @contact.email = email
      assert @contact.valid?, "#{email} should be valid"
    end
  end

  test "should allow blank email" do
    @contact.email = ""
    assert @contact.valid?
  end

  test "should validate phone format" do
    valid_phones = ["+420123456789", "123-456-789", "(123) 456-789", "123 456 789"]
    valid_phones.each do |phone|
      @contact.phone = phone
      assert @contact.valid?, "#{phone} should be valid"
    end
  end

  test "should allow blank phone" do
    @contact.phone = ""
    assert @contact.valid?
  end

  # Associations
  test "should belong to user" do
    assert_respond_to @contact, :user
    assert_kind_of User, @contact.user
  end

  test "should have many notes" do
    assert_respond_to @contact, :notes
  end

  test "should destroy associated notes when contact is destroyed" do
    @contact.save!
    note = @contact.notes.create!(content: "Test note", user: @user)
    
    assert_difference "Note.count", -1 do
      @contact.destroy
    end
  end

  # Business Logic
  test "should have full_name method" do
    assert_equal "Jan Novák", @contact.full_name
  end

  test "should have initials method" do
    assert_equal "JN", @contact.initials
  end

  test "should handle single name for initials" do
    @contact.name = "Jan"
    assert_equal "JA", @contact.initials
  end

  test "should update last_contacted_at when note is created" do
    @contact.save!
    assert_nil @contact.last_contacted_at

    freeze_time = Time.current
    travel_to freeze_time do
      @contact.notes.create!(content: "Test note", user: @user)
      @contact.reload
      assert_equal freeze_time.to_i, @contact.last_contacted_at.to_i
    end
  end

  test "should scope search by name" do
    @contact.save!
    other_contact = Contact.create!(
      name: "Petr Svoboda",
      email: "petr@example.com",
      user: @user
    )

    results = Contact.search("Jan")
    assert_includes results, @contact
    assert_not_includes results, other_contact
  end

  test "should scope search by email" do
    @contact.save!
    
    results = Contact.search("jan@example")
    assert_includes results, @contact
  end

  test "should scope search by company" do
    @contact.save!
    
    results = Contact.search("Test Company")
    assert_includes results, @contact
  end

  test "should scope search case insensitive" do
    @contact.save!
    
    results = Contact.search("JAN")
    assert_includes results, @contact
    
    results = Contact.search("test company")
    assert_includes results, @contact
  end

  # Birthday validation
  test "should accept valid birthday" do
    @contact.birthday = Date.parse("1990-01-01")
    assert @contact.valid?
  end

  test "should not accept future birthday" do
    @contact.birthday = Date.tomorrow
    assert_not @contact.valid?
  end

  test "should calculate age" do
    @contact.birthday = 30.years.ago.to_date
    @contact.save!
    
    assert_equal 30, @contact.age
  end

  test "should handle missing birthday for age" do
    @contact.birthday = nil
    @contact.save!
    
    assert_nil @contact.age
  end
end
