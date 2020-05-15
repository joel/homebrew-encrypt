# frozen_string_literal: true

require 'optparse'
require 'clipboard'
require 'passgen'

module Passy
  class OptparseExample
    class ScriptOptions
      attr_accessor :password, :verbose, :direction, :clipboard, :generate

      def initialize
        self.verbose = false
        self.clipboard = false
        self.generate = false
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
        boolean_generate_option(parser)

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

      def boolean_generate_option(parser)
        # Boolean switch.
        parser.on("-v", "--[no-]generate", "Generate password") do |g|
          self.generate = g
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

      if !options.generate && !options.clipboard && !options.password
        help(example.option_parser)
        exit(1)
      end

      unless %i[forward backward].include?(options.direction.to_sym)
        help(example.option_parser)
        exit(1)
      end
    end

    def convert
      if options.generate
        s = Passgen::generate({
          :length => 30,
          :symbols => true,
          :lowercase => true,
          :uppercase => true,
          :digits => true
        })
        Clipboard.copy s
        puts s
      else
        password = options.clipboard ? Clipboard.paste : options.password
        s = Encryptor.new.encrypt(password: password, direction: options.direction)
        Clipboard.copy s
        puts s
      end
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
      puts("")
      puts("Generate a password")
      puts("encrypt --generate")
      puts("")
      puts("/i?T1%sBUXQ6jkHP57h%pEHVF?!tmE+tQ4vwkaVd6uese")
      puts("-----------------------------------------------------------------------------------")
      puts("")
      puts("Get printable version")
      puts("encrypt --clipboard")
      puts("")
      puts("+i!T6?sbuxq7JKhp59H%pehvf%?tMe/tq4VWKAvD7UESE")
      puts("-----------------------------------------------------------------------------------")
      puts("")
      puts("Get back password")
      puts("encrypt --clipboard --direction 'backward'")
      puts("")
      puts("/i?T1%sBUXQ6jkHP57h%pEHVF?!tmE+tQ4vwkaVd6uese")
      puts("-----------------------------------------------------------------------------------")
      puts("")
      puts("Get back password")
      puts("encrypt --password '+i!T6?sbuxq7JKhp59H%pehvf%?tMe/tq4VWKAvD7UESE' --direction 'backward'")
      puts("")
      puts("/i?T1%sBUXQ6jkHP57h%pEHVF?!tmE+tQ4vwkaVd6uese")
    end

    attr_reader :options
  end
end
