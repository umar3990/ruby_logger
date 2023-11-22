# Ruby Logger Library

## Overview

The Ruby Logger Library is a versatile logging solution for Ruby applications. It provides a flexible framework for logging messages to various sinks, allowing developers to configure and customize logging behavior according to their needs.

## File Structure

ruby_logger_library/
│
├── lib/
│ ├── logger/
│ │ ├── message.rb
│ │ ├── sink.rb
│ │ └── logger.rb
│ │
│ └── logger.rb
│
├── config/
│ └── logger_config.rb
│
├── example_usage.rb
│
└── README.md


## Features

- **Message:** A structured representation of a log message with content, level, and namespace.
  
- **Sink:** A destination for log messages (e.g., text file, database) tied to specific message levels.
  
- **Logger:** A central logger class that routes messages to the appropriate sinks based on their levels.

- **Configuration:** Easily configurable via the `logger_config.rb` file, supporting multiple sinks and log levels.

- **Log Rotation:** Automatic log rotation based on file size, with compression of previous log files.

## Getting Started

1. Clone the repository:

   ```bash
   git clone https://github.com/your-username/ruby_logger_library.git

Navigate to the project directory:

cd logger_library

Install any necessary dependencies (there are none for this example).

Configure your logging settings in config/logger_config.rb.

Use the library in your Ruby application:

require_relative 'lib/logger'

# Example configuration
config = {
  ts_format: 'ddmmyyyyhhmmss',
  sinks: [
    { type: 'FILE', levels: ['DEBUG', 'INFO'], file_location: '/var/log/app/info.log' }
    # Add more sink configurations as needed
  ]
}

# Create logger instance
logger = Logger.new(config)

# Create and log messages
message1 = Message.new('Empty txnIds Nothing to fetch', 'INFO', 'Namespace1')
message2 = Message.new('No user found for the phone number', 'WARN', 'Namespace2')

logger.log(message1)
logger.log(message2)





lib/logger/message.rb: This file contains the definition of the Message class.

lib/logger/sink.rb: This file contains the definition of the Sink class.

lib/logger/logger.rb: This file contains the definition of the Logger class.

lib/logger.rb: This file can serve as an entry point for requiring all the logger-related classes. It can include the necessary class files.

config/logger_config.rb: This file contains the configuration for the logger.

demo_usage.rb: This file demonstrates how to use the logger library. It requires the necessary files and uses the classes.

README.md: A documentation file that explains the purpose of the library, how to set it up, and example usage.