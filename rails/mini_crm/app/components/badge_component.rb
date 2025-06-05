class BadgeComponent < ViewComponent::Base
  def initialize(text:, variant: :default, size: :md)
    @text = text
    @variant = variant
    @size = size
  end

  private

  attr_reader :text, :variant, :size

  def classes
    base_classes = "inline-flex items-center font-medium rounded-full"
    
    size_classes = case size
    when :sm
      "px-2 py-0.5 text-xs"
    when :md
      "px-2.5 py-0.5 text-sm"
    when :lg
      "px-3 py-0.5 text-sm"
    else
      "px-2.5 py-0.5 text-sm"
    end

    variant_classes = case variant
    when :success
      "bg-green-100 text-green-800 dark:bg-green-900 dark:text-green-300"
    when :warning
      "bg-yellow-100 text-yellow-800 dark:bg-yellow-900 dark:text-yellow-300"
    when :danger
      "bg-red-100 text-red-800 dark:bg-red-900 dark:text-red-300"
    when :info
      "bg-blue-100 text-blue-800 dark:bg-blue-900 dark:text-blue-300"
    when :secondary
      "bg-gray-100 text-gray-800 dark:bg-gray-700 dark:text-gray-300"
    else
      "bg-gray-100 text-gray-800 dark:bg-gray-700 dark:text-gray-300"
    end

    "#{base_classes} #{size_classes} #{variant_classes}"
  end
end 