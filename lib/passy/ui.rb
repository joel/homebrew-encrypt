# frozen_string_literal: true

require 'optparse'
require 'clipboard'
require 'passgen'
require 'erb'

module Passy
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
      attr_accessor :password, :verbose, :direction, :clipboard, :generate, :show, :symbols, :length

      def initialize
        self.verbose = false
        self.clipboard = false
        self.generate = false
        self.show = false
        self.direction = 'forward'
        self.symbols = true
        self.length = 30
      end

      def define_options(parser)
        parser.banner = "Usage: Passy [options]"
        parser.separator ""
        parser.separator "Specific options:"

        # add additional options
        direction_option(parser)
        password_option(parser)
        password_length_option(parser)

        boolean_verbose_option(parser)
        boolean_clipboard_option(parser)
        boolean_generate_option(parser)
        boolean_show_option(parser)
        boolean_symbols_option(parser)

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

      def password_length_option(parser)
        parser.on('-l LENGTH', '--length LENGTH', '[OPTIONAL] Password length', String) do |length|
          self.length = length
        end
      end

      def boolean_verbose_option(parser)
        # Boolean switch.
        parser.on("-v", "--[no-]verbose", "Run verbosely") do |v|
          self.verbose = v
        end
      end

      def boolean_symbols_option(parser)
        # Boolean switch.
        parser.on("-i", "--[no-]symbols", "Do not include symbols") do |i|
          self.symbols = i
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
      generated_password = nil

      if options.generate
        generated_password = Passgen::generate({
          :length => options.length,
          :symbols => options.symbols,
          :lowercase => true,
          :uppercase => true,
          :digits => true
        })
      else
        password = options.clipboard ? Clipboard.paste : options.password
        generated_password = Encryptor.new.encrypt(password: password, direction: options.direction)
      end

      @password = generated_password
      Clipboard.copy(generated_password)
      show_in_browser if options.show

      generated_password
    end

    def show_in_browser
      File.open('generated_password.html', 'w') { |f| f.write(Html.new(self.password).render) }
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

    attr_reader :options, :password
  end
end
