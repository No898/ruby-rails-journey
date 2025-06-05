require "test_helper"

class AvatarComponentTest < ViewComponent::TestCase
  test "renders with gravatar when email is provided" do
    component = AvatarComponent.new(
      name: "Jan Novák",
      email: "jan@example.com",
      size: :md
    )
    
    render_inline(component)
    
    # Should contain an img tag with gravatar URL
    assert_selector "img[src*='gravatar.com']"
    assert_selector "img[alt='Jan Novák']"
    assert_no_selector "span"  # No initials fallback
  end

  test "renders with colored initials when no email provided" do
    component = AvatarComponent.new(
      name: "Jan Novák",
      size: :md
    )
    
    render_inline(component)
    
    # Should contain initials, no img tag
    assert_selector "span", text: "JN"
    assert_no_selector "img"
    
    # Should have background color class
    assert_selector "div[class*='bg-']"
  end

  test "renders with custom src when provided" do
    component = AvatarComponent.new(
      name: "Jan Novák",
      email: "jan@example.com",
      src: "/custom-avatar.jpg",
      size: :md
    )
    
    render_inline(component)
    
    # Should use custom src, not gravatar
    assert_selector "img[src='/custom-avatar.jpg']"
    assert_no_selector "img[src*='gravatar.com']"
  end

  test "generates consistent background colors for same name" do
    component1 = AvatarComponent.new(name: "Jan Novák")
    component2 = AvatarComponent.new(name: "Jan Novák")
    
    # Same name should always get same color
    assert_equal component1.send(:background_color), component2.send(:background_color)
  end

  test "generates different background colors for different names" do
    component1 = AvatarComponent.new(name: "Jan Novák")
    component2 = AvatarComponent.new(name: "Petr Svoboda")
    
    # Different names should get different colors (most of the time)
    color1 = component1.send(:background_color)
    color2 = component2.send(:background_color)
    
    # This might occasionally fail due to hash collisions, but very unlikely
    assert_not_equal color1, color2
  end

  test "handles different size variants" do
    sizes = [:sm, :md, :lg, :xl]
    
    sizes.each do |size|
      component = AvatarComponent.new(name: "Test User", size: size)
      render_inline(component)
      
      # Should have appropriate size class
      expected_classes = {
        sm: "w-8 h-8",
        md: "w-10 h-10", 
        lg: "w-12 h-12",
        xl: "w-16 h-16"
      }
      
      assert_selector "div[class*='#{expected_classes[size]}']"
    end
  end

  test "generates proper initials from full name" do
    test_cases = [
      ["Jan Novák", "JN"],
      ["Jan", "J"],
      ["Jan Pavel Novák", "JN"],  # Should take first and last
      ["", ""],
      ["   ", ""]
    ]
    
    test_cases.each do |name, expected_initials|
      component = AvatarComponent.new(name: name)
      assert_equal expected_initials, component.send(:initials)
    end
  end

  test "generates gravatar URL with correct parameters" do
    component = AvatarComponent.new(
      name: "Jan Novák",
      email: "JAN@EXAMPLE.COM",  # Test case insensitive
      size: :lg
    )
    
    url = component.send(:avatar_url)
    
    # Should be lowercase MD5 hash of email
    expected_hash = Digest::MD5.hexdigest("jan@example.com")
    assert_includes url, expected_hash
    
    # Should include identicon fallback and size
    assert_includes url, "d=identicon"
    assert_includes url, "s=48"  # lg size = 48px
  end

  test "handles whitespace in email for gravatar" do
    component = AvatarComponent.new(
      name: "Test User",
      email: "  test@example.com  ",
      size: :md
    )
    
    url = component.send(:avatar_url)
    expected_hash = Digest::MD5.hexdigest("test@example.com")
    assert_includes url, expected_hash
  end

  test "returns nil avatar_url when no email" do
    component = AvatarComponent.new(name: "Test User")
    assert_nil component.send(:avatar_url)
  end

  test "returns nil avatar_url when email is blank" do
    component = AvatarComponent.new(name: "Test User", email: "")
    assert_nil component.send(:avatar_url)
  end

  test "uses custom src over gravatar" do
    component = AvatarComponent.new(
      name: "Test User",
      email: "test@example.com",
      src: "/custom.jpg"
    )
    
    assert_equal "/custom.jpg", component.send(:avatar_url)
  end

  test "renders with proper CSS classes" do
    component = AvatarComponent.new(name: "Test User", size: :md)
    render_inline(component)
    
    # Should have rounded-full and flex classes
    assert_selector "div.rounded-full"
    assert_selector "div.overflow-hidden"
    assert_selector "div.flex"
    assert_selector "div.items-center"
    assert_selector "div.justify-center"
  end

  test "renders initials with proper styling" do
    component = AvatarComponent.new(name: "Test User")
    render_inline(component)
    
    # Initials should have proper text styling
    assert_selector "span.font-semibold"
    assert_selector "span.text-white"
    assert_selector "span", text: "TU"
  end
end 