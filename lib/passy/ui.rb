# frozen_string_literal: true

require 'optparse'
require 'clipboard'

module Passy
  class OptparseExample
    class ScriptOptions
      attr_accessor :password, :verbose, :direction, :clipboard

      def initialize
        self.verbose = false
        self.clipboard = false
        self.direction = 'forward'
      end

      def define_options(parser)
        parser.banner = "Usage: Passy [options]"
        parser.separator ""
        parser.separator "Specific options:"

        # add additional options
        direction_option(parser)
        password_option(parser)

        boolean_verbose_option(parser)
        boolean_clipboard_option(parser)

        parser.separator ""
        parser.separator "Common options:"

        # No argument, shows at tail.  This will print an options summary.
        # Try it and see!
        parser.on_tail("-h", "--help", "Show this message") do
          puts parser
          exit
        end
        # Another typical switch to print the version.
        parser.on_tail("--version", "Show version") do
          puts Passy::VERSION
          exit
        end
      end

      def direction_option(parser)
        parser.on('-d ENCRYPTION_MODE', '--direction ENCRYPTION_MODE', '[OPTIONAL] Encryption (default) Or Decryption', String) do |direction|
          self.direction = direction
        end
      end

      def password_option(parser)
        parser.on('-p PASSWORD', '--password PASSWORD', '[REQUIRED] Password', String) do |password|
          self.password = password
        end
      end

      def boolean_verbose_option(parser)
        # Boolean switch.
        parser.on("-v", "--[no-]verbose", "Run verbosely") do |v|
          self.verbose = v
        end
      end

      def boolean_clipboard_option(parser)
        # Boolean switch.
        parser.on("-c", "--[no-]clipboard", "Get the content from the clipboard") do |c|
          self.clipboard = c
        end
      end
    end

    #
    # Return a structure describing the options.
    #
    def parse(args)
      # The options specified on the command line will be collected in
      # *options*.
      @options = ScriptOptions.new
      @option_parser = OptionParser.new do |parser|
        @options.define_options(parser)
        parser.parse!(args)
      end
      @options
    end

    attr_reader :parser, :options, :option_parser
  end  # class OptparseExample

  class Ui
    def initialize
      example = OptparseExample.new
      @options = example.parse(ARGV)

      if !options.clipboard && !options.password
        help(example.option_parser)
        exit(1)
      end

      unless %i[forward backward].include?(options.direction.to_sym)
        help(example.option_parser)
        exit(1)
      end
    end

    def convert
      password = options.clipboard ? Clipboard.paste : options.password
      s = Encryptor.new.encrypt(password: password, direction: options.direction)
      Clipboard.copy s
      puts s
    end

    def help(opts)
      puts(opts)
      puts("-----------------------------------------------------------------------------------")
      puts("bin/encrypt.rb --password '1%195bDf!g' --direction 'forward'")
      puts("[OPTION] --direction:")
      puts("")
      puts("    --direction 'forward'")
      puts("    --direction 'backward'")
      puts("-----------------------------------------------------------------------------------")
    end

    attr_reader :options
  end
end
