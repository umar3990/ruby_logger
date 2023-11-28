# demo_usage.rb

require_relative 'lib/logger'

logger = Logger.new(CONFIG)

# message1 = Message.new('Empty txnIds Nothing to fetch', 'INFO', 'Namespace1')
# message2 = Message.new('No user found for the phone number', 'WARN', 'Namespace2')

#For testing the logs file rotation and compression
1000000.times do |t|
    message1 = Message.new('Empty txnIds Nothing to fetch ' + t.to_s, 'INFO', 'Namespace1')
    logger.log(message1)
end