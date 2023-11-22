# lib/logger/logger.rb

class Logger
    attr_reader :config, :sinks
  
    def initialize(config)
      @config = config
      @sinks = []
  
      # Initialize sinks based on the configuration
      initialize_sinks
    end
  
    def add_sink(sink)
      @sinks << sink
    end
  
    def log(message)
      # Route the message to the appropriate sink
      @sinks.each do |sink|
        sink.log(message, config[:ts_format]) if sink.levels.include?(message.level)
      end
    end
  
    private
  
    def initialize_sinks
      # Implement logic to initialize sinks based on the configuration
      @config[:sinks].each do |sink|
        new_sink = Sink.new(sink[:levels], sink[:type], sink[:details])
        add_sink(new_sink)
      end
    end
  end
  