require "logger"

module Minidb
  class Logger < ::Logger
    @@instance : Minidb::Logger = Minidb::Logger.new(STDOUT)

    def self.build(io: (IO | String) = STDOUT, 
        level: Int32 = 1, 
        hostname: String = "127.0.0.1", 
        port: Int32 = 5555)
        
        if io.is_a?(String)
            basename = File.basename(io, ".log")
        end
    end
  end
end
