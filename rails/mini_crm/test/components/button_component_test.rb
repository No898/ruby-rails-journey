require "test_helper"

class ButtonComponentTest < ViewComponent::TestCase
  test "renders as link when href is provided" do
    component = ButtonComponent.new(text: "Click me", href: "/test")
    render_inline(component)
    
    assert_selector "a[href='/test']", text: "Click me"
    assert_no_selector "button"
  end

  test "renders as button when no href provided" do
    component = ButtonComponent.new(text: "Submit")
    render_inline(component)
    
    assert_selector "button", text: "Submit"
    assert_no_selector "a"
  end

  test "renders with custom button type" do
    component = ButtonComponent.new(text: "Submit", type: :submit)
    render_inline(component)
    
    assert_selector "button[type='submit']", text: "Submit"
  end

  test "renders primary variant with correct styling" do
    component = ButtonComponent.new(text: "Primary", variant: :primary)
    render_inline(component)
    
    assert_selector "button.bg-blue-600"
    assert_selector "button.text-white"
    assert_selector "button.hover\\:bg-blue-700"
  end

  test "renders secondary variant with correct styling" do
    component = ButtonComponent.new(text: "Secondary", variant: :secondary)
    render_inline(component)
    
    assert_selector "button.bg-gray-100"
    assert_selector "button.text-gray-900"
    assert_selector "button.hover\\:bg-gray-200"
  end

  test "renders danger variant with correct styling" do
    component = ButtonComponent.new(text: "Delete", variant: :danger)
    render_inline(component)
    
    assert_selector "button.bg-red-600"
    assert_selector "button.text-white"
    assert_selector "button.hover\\:bg-red-700"
  end

  test "renders link variant with correct styling" do
    component = ButtonComponent.new(text: "Link", variant: :link)
    render_inline(component)
    
    assert_selector "button.text-blue-600"
    assert_selector "button.hover\\:text-blue-800"
    assert_no_selector "button.bg-"  # Should not have background
  end

  test "applies custom classes" do
    component = ButtonComponent.new(
      text: "Custom", 
      classes: "my-custom-class another-class"
    )
    render_inline(component)
    
    assert_selector "button.my-custom-class"
    assert_selector "button.another-class"
  end

  test "merges custom classes with variant classes" do
    component = ButtonComponent.new(
      text: "Custom Primary",
      variant: :primary,
      classes: "w-full"
    )
    render_inline(component)
    
    # Should have both variant and custom classes
    assert_selector "button.bg-blue-600"  # From primary variant
    assert_selector "button.w-full"       # Custom class
  end

  test "renders with data attributes" do
    component = ButtonComponent.new(
      text: "Confirm",
      data: { confirm: "Are you sure?", turbo_method: :delete }
    )
    render_inline(component)
    
    assert_selector "button[data-confirm='Are you sure?']"
    assert_selector "button[data-turbo-method='delete']"
  end

  test "renders link with target attribute" do
    component = ButtonComponent.new(
      text: "External Link",
      href: "https://example.com",
      target: "_blank"
    )
    render_inline(component)
    
    assert_selector "a[href='https://example.com'][target='_blank']"
  end

  test "handles disabled state for button" do
    component = ButtonComponent.new(text: "Disabled", disabled: true)
    render_inline(component)
    
    assert_selector "button[disabled]"
    assert_selector "button.opacity-50"
    assert_selector "button.cursor-not-allowed"
  end

  test "handles disabled state for link" do
    component = ButtonComponent.new(
      text: "Disabled Link",
      href: "/test",
      disabled: true
    )
    render_inline(component)
    
    assert_selector "a.opacity-50"
    assert_selector "a.cursor-not-allowed"
    assert_selector "a.pointer-events-none"
  end

  test "renders with icon content" do
    component = ButtonComponent.new(text: "")
    
    render_inline(component) do
      '<svg class="w-4 h-4"><path d="..."/></svg>'.html_safe
    end
    
    assert_selector "button svg"
  end

  test "applies all base button classes" do
    component = ButtonComponent.new(text: "Test")
    render_inline(component)
    
    # Check for common base classes
    base_classes = [
      "inline-flex", "items-center", "justify-center",
      "px-4", "py-2", "border", "rounded-lg",
      "font-medium", "text-sm", "transition-colors",
      "focus\\:outline-none", "focus\\:ring-2"
    ]
    
    base_classes.each do |css_class|
      assert_selector "button.#{css_class}"
    end
  end

  test "defaults to primary variant when none specified" do
    component = ButtonComponent.new(text: "Default")
    render_inline(component)
    
    # Should have primary variant classes by default
    assert_selector "button.bg-blue-600"
    assert_selector "button.text-white"
  end

  test "handles empty text gracefully" do
    component = ButtonComponent.new(text: "")
    render_inline(component)
    
    assert_selector "button"
    # Should still render, just with empty content
  end

  test "escapes HTML in text" do
    component = ButtonComponent.new(text: "<script>alert('xss')</script>")
    render_inline(component)
    
    # Should render the text escaped, not as HTML
    assert_selector "button", text: "<script>alert('xss')</script>"
    assert_no_selector "script"
  end

  test "renders method override for link with non-GET method" do
    component = ButtonComponent.new(
      text: "Delete",
      href: "/contacts/1",
      data: { turbo_method: :delete }
    )
    render_inline(component)
    
    assert_selector "a[data-turbo-method='delete']"
  end

  test "includes focus ring classes for accessibility" do
    component = ButtonComponent.new(text: "Accessible")
    render_inline(component)
    
    assert_selector "button.focus\\:ring-2"
    assert_selector "button.focus\\:ring-blue-500"
  end

  test "handles Czech text properly" do
    component = ButtonComponent.new(text: "Uložit změny")
    render_inline(component)
    
    assert_selector "button", text: "Uložit změny"
  end

  test "renders with proper ARIA attributes when disabled" do
    component = ButtonComponent.new(text: "Disabled", disabled: true)
    render_inline(component)
    
    assert_selector "button[disabled][aria-disabled='true']"
  end
end 