# config/logger_config.rb

CONFIG = {
  ts_format: 'ddmmyyyyhhmmss',
  sinks: [
    { type: 'FILE', levels: ['DEBUG', 'INFO', 'WARN', 'ERROR,', 'FATAL'], details: { file_location: '/var/log/app/info.log' } },
    { type: 'DB', levels: ['DEBUG', 'INFO', 'WARN', 'ERROR,', 'FATAL'], details: { ip: '3232.324324.234' } },
    { type: 'CONSOLE', levels: ['DEBUG', 'INFO', 'WARN', 'ERROR,', 'FATAL'], details: { } }
  ]
}
