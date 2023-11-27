# lib/logger/sink.rb

require 'date'

class Sink
    attr_reader :levels, :type, :details

    MAX_FILE_SIZE = 1 * 1024 * 1024 # 1 MB
  
    def initialize(levels, type, details)
      @levels = levels
      @type = type
      @details = details
    end
  
    def log(message, ts_format)
      @ts_format = ts_format
      log_entry = format_log_entry(message)
    
      case type
      when 'FILE'
        log_to_file(log_entry)
      when 'CONSOLE'
        log_to_console(log_entry)
      else
        puts "Unsupported log type: #{type}"
      end
    end
    
    private

    def log_to_file(log_entry)
      # Append the log entry to the file
      begin
        File.open("info.log", 'a') { |file| file.puts(log_entry) }
      rescue StandardError => e
        puts "Error writing to log file: #{e.message}"
      end
      rotate_logs if needs_rotation?
    end
    
    def log_to_console(log_entry)
      # Print the log entry to the console
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
    

    def needs_rotation?
      # Determine whether log rotation is needed based on file size
      File.size("info.log") > MAX_FILE_SIZE
    end

    def rotate_logs
      current_file = details[:file_location]

      # Compress the current log file
      compress_file(current_file)

      # Rename the compressed file to the original filename
      compressed_file = "#{current_file}.gz"
      File.rename(compressed_file, current_file)

      # Optionally, create a new empty log file
      File.open(current_file, 'w') {}
    end

    def compress_file(file_path)
      # Use gzip to compress the log file
      system("gzip #{file_path}")
    end
  end
  