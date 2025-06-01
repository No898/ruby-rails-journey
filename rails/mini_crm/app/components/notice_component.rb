# frozen_string_literal: true

class NoticeComponent < ViewComponent::Base
  attr_reader :message, :type, :classes

  def initialize(message:, type: :success, classes: '')
    @message = message
    @type = type
    @classes = classes
  end

  def base_classes
    common_classes = 'py-2 px-3 mb-5 font-medium rounded-md inline-block'
    type_classes = case type
          when :success
            'bg-green-50 text-green-600 dark:bg-green-900 dark:text-green-200'
          when :alert
            'bg-red-50 text-red-500 dark:bg-red-900 dark:text-red-200'
          when :warning
            'bg-yellow-50 text-yellow-700 dark:bg-yellow-900 dark:text-yellow-300'
          when :info
            'bg-blue-50 text-blue-600 dark:bg-blue-900 dark:text-blue-300'
          else
            'bg-gray-100 text-gray-700 dark:bg-gray-800 dark:text-gray-200'
          end

    
    [common_classes, type_classes].join(' ')
  end
end 