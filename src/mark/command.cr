require "../mark"
require "option_parser"

class Mark::Command
  def initialize(@args : Array(String) = ARGV)
  end

  def run
    opts = parse_args
    return unless opts

    opts.validate!
    Renderer.new(opts).render
    open_target(opts)
  rescue error : OptionParser::InvalidOption | Options::OptionError
    puts error
  end

  private def parse_args
    options = Hash(Symbol, String).new
    OptionParser.parse(@args) do |parser|
      parser.banner = "Usage: mark [options] source1.md source2.md ..."

      parser.on("-h", "--help", "Print this help message") { print_help(parser) }
      parser.on("-v", "--version", "Print version") { print_version }
      parser.on("-t FILE", "--target FILE", "Target file for HTML") { |t| options[:target] = t }
      parser.on("-T FILE", "--template FILE", "Template file for HTML") { |t| options[:template] = t }
      parser.on("-o CMD", "--open CMD", "Open browser command") { |o| options[:open] = o }
    end

    Options.new(@args, options)
  end

  private def print_version
    puts VERSION
    exit(0)
  end

  private def print_help(parser : OptionParser)
    puts parser
    exit(0)
  end

  private def open_target(opts)
    system(opts.open_command)
  end
end
