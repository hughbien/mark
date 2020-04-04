require "../mark"
require "file_utils"
require "option_parser"

# Mark::Command#run is the main method which kicks off everything.
# Frontend which talks to the user. Handles parsing arguments, printing errors, and printing help.
class Mark::Command
  def initialize(@args : Array(String) = ARGV, @io : IO = STDOUT)
  end

  def run
    opts = parse_args
    return unless opts

    opts.validate!
    Renderer.new(opts).render
    open_target(opts)
    remove_target(opts)
  rescue error : OptionParser::InvalidOption | Options::OptionError
    log(error)
  end

  private def parse_args
    options = Hash(Symbol, String).new
    quit = false

    OptionParser.parse(@args) do |parser|
      parser.banner = "Usage: mark [options] source1.md source2.md ..."

      parser.on("-h", "--help", "Print this help message") { print_help(parser); quit = true }
      parser.on("-v", "--version", "Print version") { print_version; quit = true }
      parser.on("-t", "--target FILE", "Target file for HTML") { |t| options[:target] = t }
      parser.on("-T", "--template FILE", "Template file for HTML") { |t| options[:template] = t }
      parser.on("-k", "--keep", "Keep target after generating HTML") { options[:keep] = "1" }
      parser.on("-o", "--open CMD", "Open browser command") { |o| options[:open] = o }
    end

    quit ? nil : Options.new(@args, options)
  end

  private def print_version
    log(VERSION)
  end

  private def print_help(parser : OptionParser)
    log(parser)
  end

  private def open_target(opts)
    system(opts.open_command)
  end

  private def remove_target(opts)
    return if opts.keep

    sleep(0.2) # give the browser some time to open target before removing :(
    FileUtils.rm(opts.target)
  end

  private def log(message)
    @io.puts message
  end
end
