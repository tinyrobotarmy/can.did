module ApplicationHelper
  def message_box(message)
    content_provided = message.nil? || message.empty?
    content = link_to(raw('&times;'), '#', :class => 'close')
    content << raw(content_provided ? flash_content : message)
    content_tag 'div', raw(content), :class => 'message-box'
  end

  def flash_content
    content = ''
    flash.each do |key, msg|
      content << content_tag(:div, msg, :class => key)
    end
    content.empty? ? nil : content
  end
end
