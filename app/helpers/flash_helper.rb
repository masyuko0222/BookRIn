# frozen_string_literal: true

module FlashHelper
  def bg_color_by_message_type(type)
    case type.to_sym
    when :notice then 'bg-green-500 bg-opacity-50'
    when :alert  then 'bg-red-500 bg-opacity-50'
    else 'bg-gray-500'
    end
  end
end
