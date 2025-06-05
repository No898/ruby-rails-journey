# frozen_string_literal: true

class ButtonComponent < ViewComponent::Base
  attr_reader :text, :href, :variant, :type, :data, :classes, :method, :disabled, :target
  
  def initialize(text:, href: nil, variant: :primary, type: :link, data: {}, classes: '', method: nil, disabled: false, target: nil)
    @text = text
    @href = href
    @variant = variant
    @type = type
    @data = data
    @classes = classes
    @method = method
    @disabled = disabled
    @target = target
  end

  def base_classes
    common_classes = 'inline-flex items-center justify-center px-4 py-2 border rounded-lg font-medium text-sm transition-colors focus:outline-none focus:ring-2 focus:ring-blue-500 align-middle'
    
    variant_classes = case variant
                      when :primary
                        'bg-blue-600 hover:bg-blue-700 text-white border-blue-600 dark:bg-blue-700 dark:hover:bg-blue-800'
                      when :secondary
                        'bg-gray-100 hover:bg-gray-200 text-gray-800 text-gray-900 border-gray-300 dark:bg-gray-600 dark:hover:bg-gray-700 dark:text-white'
                      when :danger
                        'bg-red-600 hover:bg-red-700 text-white border-red-600 dark:bg-red-700 dark:hover:bg-red-800'
                      when :link
                        'text-blue-600 hover:text-blue-800 bg-transparent border-transparent'
                      else
                        'bg-blue-600 hover:bg-blue-700 text-white border-blue-600' # Default to primary
                      end
    
    disabled_classes = if @disabled
      if @href
        'opacity-50 cursor-not-allowed pointer-events-none'
      else
        'opacity-50 cursor-not-allowed'
      end
    else
      ''
    end
    
    [common_classes, variant_classes, disabled_classes, @classes].join(' ').strip
  end
end 