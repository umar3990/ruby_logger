# lib/logger/file_logger.rb

require 'fileutils'
require 'zlib'

class FileLogger
  MAX_FILE_SIZE = 1 * 1024 * 1024 # 1 MB
  FILE_EXTENSION = '.gz'.freeze

  def initialize(file_path)
    @file_path = file_path
    # ensure_directory_exists
    # raise ArgumentError, 'Invalid file path' unless valid_file_path?(@file_path)
  end

  def log(message)
    rotate_file_if_needed
    begin
      File.open(@file_path, 'a') { |file| file.puts(message) }
    rescue StandardError => e
      puts "Error writing to log file: #{e.message}"
    end
  end

  private

  def rotate_file_if_needed
    return unless File.exist?(@file_path) && File.size(@file_path) >= MAX_FILE_SIZE

    rotate_and_compress_log
  end

  def rotate_and_compress_log
    compress_current_log
    create_empty_log_file
  rescue StandardError => e
    puts "Error: #{e.message}"
  end

  def compress_current_log
    compressed_file = "#{@file_path}.#{next_file_count}#{FILE_EXTENSION}"
    Zlib::GzipWriter.open(compressed_file) do |gz|
      gz.write IO.binread(@file_path)
    end
  end

  def next_file_count
    count = 1
    count += 1 while File.exist?("#{@file_path}.#{count}#{FILE_EXTENSION}")
    count
  end

  def create_empty_log_file
    File.open(@file_path, 'w') {}
  end

  # def valid_file_path?(path)
  #   dir = File.dirname(path)
  #   return true if File.directory?(dir) && File.writable?(dir)

  #   puts "Invalid file path: #{path}. The directory #{dir} is not writable or does not exist. Consider specifying a user-specific directory."
  #   false
  # end

  # def ensure_directory_exists
  #   dir = File.dirname(@file_path)
  #   FileUtils.mkdir_p(dir) unless File.directory?(dir)
  # end
end
