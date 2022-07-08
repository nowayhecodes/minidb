require "logger"

module Minidb
  class Logger < ::Logger
    @@instance : Minidb::Logger = Minidb::Logger.new(STDOUT)

    def self.build(io : (IO | String) = STDOUT,
                   level : Int32 = 1,
                   hostname : String = "127.0.0.1",
                   port : Int32 = 5555)
      if io.is_a?(String)
        basename = File.basename(io, ".log")
        path = File.dirname(io)
        timestamp = Time.now.to_s("%Y%m%d%H%M%S")

        io = File.new("#{path}/#{basename}_#{timestamp}.log", "w")
      end

      @@instance = Minidb::Logger.new(io)
      @@instance.level = Minidb::Logger::Severity.new(level)
      @@instance.formatter = Minidb::Logger::Formatter.new do |severity, datetime, progname, message, io|
        datetime = datetime.to_utc.to_s("%Y-%m-%d %H:%M:%S.%L")
        io << "[minidb][#{hostname}:#{port}][#{datetime}][#{severity}] #{message}"
      end
    end

    def self.instance
      self.build if @@instance.nil?
      @@instance
    end
  end
end
