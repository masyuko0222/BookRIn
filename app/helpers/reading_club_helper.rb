# frozen_string_literal: true

module ReadingClubHelper
  def radio_button_with_label(form, method, tag_value, options = {})
    id = options[:id]
    checked = options[:checked]
    label_text = options[:label_text]

    content_tag :label, class: 'inline-flex items-center space-x-1' do
      concat(form.radio_button(method, tag_value, id:, checked:))
      concat(content_tag(:span, label_text, class: 'text-sm text-gray-700'))
    end
  end
end
