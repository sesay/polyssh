
module PolySSH
  class Cli
    attr_reader :chain

    def self.start args
      app = self.new
      app.parse_cmdline ARGV
      pp app.chain
      #app.run commands

    end

    def initialize
      @chain = NodeList.new
    end

    def parse_cmdline args
      args_current = []
      args.each do |arg|
        if arg =~ /^-/ then
          args_current << arg
        elsif arg =~ /^((.+)@)?([^:]+):?(\d+)?$/ then
          node_new = NodeEntry.new(
            user: $1,
            host: $3,
            port: $4 || 22,
            args: args_current
          )
          @chain << node_new

        else
          STDERR.puts "ERROR: Unexpected argument #{arg}"
          exit 1
        end
      end
      return @chain
    end
  end #class
end #module

