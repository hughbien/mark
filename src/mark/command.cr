require "../mark"
require "option_parser"

class Mark::Command
  def initialize(@args : Array(String) = ARGV)
  end

  def run
    opts = parse_args
    return unless opts

    Renderer.new(opts).render
  end

  private def parse_args
    OptionParser.parse(@args) do |parser|
      parser.banner = "Usage: mark [options] file1.md file2.md ..."

      parser.on("-v", "--version", "Print version") { print_version; next }
      parser.on("-h", "--help", "Print this help message") { print_help(parser); next }
    end

    Options.new(sources: @args)
  end

  private def print_version
    puts VERSION
  end

  private def print_help(parser : OptionParser)
    puts parser
  end
end
