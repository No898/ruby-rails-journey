# frozen_string_literal: true

class ButtonComponent < ViewComponent::Base
  attr_reader :text, :href, :variant, :type, :data, :classes, :method
  
  def initialize(text:, href: nil, variant: :primary, type: :link, data: {}, classes: '', method: nil)
  @text = text
  @href = href
  @variant = variant
  @type = type
  @data = data
  @classes = classes
  @method = method
end


  def base_classes
    common_classes = 'px-3.5 py-2.5 font-bold rounded focus:outline-none focus:shadow-outline align-middle'
    variant_classes = case variant
                      when :primary
                        'bg-blue-500 hover:bg-blue-700 text-white dark:bg-blue-700 dark:hover:bg-blue-800'
                      when :secondary
                        'bg-gray-300 hover:bg-gray-400 text-gray-800 dark:bg-gray-600 dark:hover:bg-gray-700 dark:text-white'
                      when :danger
                        'bg-red-600 hover:bg-red-500 text-white dark:bg-red-700 dark:hover:bg-red-800'
                      else
                        '' # Default or handle unknown variant
                      end
    
    [common_classes, variant_classes].join(' ')
  end
end 