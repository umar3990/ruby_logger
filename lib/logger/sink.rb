# lib/logger/sink.rb

require_relative 'file_logger'
require 'date'

class Sink
  attr_reader :levels, :type, :details

  def initialize(levels, type, details)
    @levels = levels
    @type = type
    @details = details
    @file_logger = FileLogger.new(details[:file_location])
  end

  def log(message, ts_format)
    @ts_format = ts_format
    log_entry = format_log_entry(message)

    case type
    when 'FILE'
      @file_logger.log(log_entry)
    when 'CONSOLE'
      log_to_console(log_entry)
    else
      puts "Unsupported log type: #{type}"
    end
  end

  private

  def log_to_console(log_entry)
    puts log_entry
  end

  def format_log_entry(message)
    timestamp = format_timestamp
    "#{message.namespace}: #{message.level} [#{timestamp}] #{message.content}"
  end

  def format_timestamp
    formatted_timestamp = case @ts_format
      when 'ddmmyyyyhhmmss'
        Time.now.strftime("%02d%02m%Y%02H%02M%S")
      when 'dd:mm:yyyy hh:mm:ss'
        Time.now.strftime("%d:%m:%Y %H:%M:%S")
      else
        Time.now.strftime("%Y-%m-%d %H:%M:%S")
      end

    formatted_timestamp
  end
end
