# frozen_string_literal: true

require 'optparse'
require 'clipboard'
require 'erb'

module Encrypt
  class Html
    attr_reader :password

    def initialize(password)
      @password = password
    end

    def render
      b = binding
      # create and run templates, filling member data variables
      html = <<-HTML
        <!doctype html>
        <html>
          <head>
            <style type="text/css">
              h1 {
                text-align: center;
                font-size: 3.5em;
              }
            </style>
          </head>
          <body>
            <h1>
              <%= @password %>
            </h1>
          </body>
        </html>
      HTML
      ERB.new(html).result(b)
    end
  end

  class OptparseExample
    class ScriptOptions
      attr_accessor :password, :verbose, :direction, :clipboard, :show

      def initialize
        self.verbose = false
        self.clipboard = false
        self.show = false
        self.direction = 'forward'
      end

      def define_options(parser)
        parser.banner = "Usage: Encrypt [options]"
        parser.separator ""
        parser.separator "Specific options:"

        # add additional options
        direction_option(parser)
        password_option(parser)

        boolean_verbose_option(parser)
        boolean_clipboard_option(parser)
        boolean_show_option(parser)

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
          puts Encrypt::VERSION
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

      def boolean_show_option(parser)
        # Boolean switch.
        parser.on("-s", "--[no-]show", "Show the password in the current browser") do |s|
          self.show = s
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
      given_password = options.clipboard ? Clipboard.paste : options.password
      @password = Encryptor.new.encrypt(password: given_password, direction: options.direction)

      Clipboard.copy(password)
      show_in_browser if options.show

      password
    end

    def show_in_browser
      File.open('generated_password.html', 'w') { |f| f.write(Html.new(password).render) }
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

    attr_reader :options, :password
  end
end
