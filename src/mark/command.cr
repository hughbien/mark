require "../mark"
require "option_parser"

class Mark::Command
  def initialize(@args : Array(String) = ARGV)
  end

  def run
    opts = parse_args
    return unless opts

    Renderer.new(opts).render
    open_target(opts)
  end

  private def parse_args
    options = Hash(Symbol, String).new
    OptionParser.parse(@args) do |parser|
      parser.banner = "Usage: mark [options] file1.md file2.md ..."

      parser.on("-h", "--help", "Print this help message") { print_help(parser); next }
      parser.on("-v", "--version", "Print version") { print_version; next }
      parser.on("-t FILE", "--target FILE", "Target file for HTML") { |t| options[:target] = t }
      parser.on("-T FILE", "--template FILE", "Template file for HTML") { |t| options[:template] = t }
      parser.on("-o CMD", "--open CMD", "Open browser command") { |o| options[:open] = o }
    end

    Options.new(@args, options)
  end

  private def print_version
    puts VERSION
  end

  private def print_help(parser : OptionParser)
    puts parser
  end

  private def open_target(opts)
    system(opts.open_command)
  end
end
