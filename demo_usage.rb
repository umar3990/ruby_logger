# demo_usage.rb

require_relative 'lib/logger'

logger = Logger.new(CONFIG)

message1 = Message.new('Empty txnIds Nothing to fetch', 'INFO', 'Namespace1')
message2 = Message.new('No user found for the phone number', 'WARN', 'Namespace2')

logger.log(message1)
logger.log(message2)
