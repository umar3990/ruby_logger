# spec/logger_spec.rb

require_relative '../lib/logger'

RSpec.describe Logger do
  let(:config_file_sink) do
    {
      ts_format: 'ddmmyyyyhhmmss',
      sinks: [
        { type: 'FILE', levels: ['DEBUG', 'INFO', 'WARN', 'ERROR', 'FATAL'], details: { file_location: 'application.log' } }
      ]
    }
  end

  let(:config_db_sink) do
    {
      ts_format: 'ddmmyyyyhhmmss',
      sinks: [
        { type: 'DB', levels: ['DEBUG', 'INFO', 'WARN', 'ERROR', 'FATAL'], details: { ip: '3232.324324.234' } }
      ]
    }
  end

  let(:logger_file_sink) { Logger.new(config_file_sink) }
  let(:logger_db_sink) { Logger.new(config_db_sink) }

  describe '#log' do
    it 'logs messages to the specified file sink' do
      message = Message.new('Test message', 'INFO', 'Namespace1')
      expect { logger_file_sink.log(message) }.not_to raise_error
    end

    it 'logs messages to the specified database sink' do
      message = Message.new('Test message', 'ERROR', 'Namespace2')
      expect { logger_db_sink.log(message) }.to output("Unsupported log type: DB\n").to_stdout
      expect { logger_db_sink.log(message) }.not_to raise_error
    end
  end

  describe '#config' do
    it 'correctly configures the file sink' do
      expect(logger_file_sink.config[:sinks][0][:type]).to eq('FILE')
      expect(logger_file_sink.config[:sinks][0][:levels]).to eq(['DEBUG', 'INFO', 'WARN', 'ERROR', 'FATAL'])
      expect(logger_file_sink.config[:sinks][0][:details][:file_location]).to eq('application.log')
    end

    it 'correctly configures the database sink' do
      expect(logger_db_sink.config[:sinks][0][:type]).to eq('DB')
      expect(logger_db_sink.config[:sinks][0][:levels]).to eq(['DEBUG', 'INFO', 'WARN', 'ERROR', 'FATAL'])
      expect(logger_db_sink.config[:sinks][0][:details][:ip]).to eq('3232.324324.234')
    end
  end
end
