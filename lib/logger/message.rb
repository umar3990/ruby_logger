# lib/logger/message.rb

class Message
  attr_accessor :content, :level, :namespace

  def initialize(content, level, namespace)
    @content = content
    @level = level
    @namespace = namespace
  end
end
  