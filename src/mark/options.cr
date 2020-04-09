require "../mark"

# Wraps arguments and options from CLI. Handles setting defaults and running validations.
#
# Example usage:
# ```
# options = Mark::Options.new(["source.md"], { :target => "/path/to/target.html" })
# options.sources         # => ["source.md"]
# options.target          # => "/path/to/target.html"
# options.template_html   # => ".... default html template ..."
# options.open_command    # => "open /path/to/target.html"
# options.keep            # => false
# options.keep_for        # => 300
# options.validate!       # => no-op since all options are valid
#
# options = Mark::Options.new([], { :target => "/path/to/target.html" })
# options.validate!       # => raises OptionError, at least one source required
# ```
class Mark::Options
  DEFAULT_TARGET = ".mark.html"
  DEFAULT_TEMPLATE = File.join(ENV["HOME"], ".mark", "template.html")
  DEFAULT_OPEN = "open %"
  DEFAULT_KEEP_FOR = "300"

  class OptionError < Exception; end

  @sources : Array(String)
  @target : String
  @template : String?
  @open : String
  @keep : Bool
  @keep_for : UInt32

  getter sources, target, keep

  def initialize(@sources, options : Hash(Symbol, String))
    @target = options.fetch(:target, ENV.fetch("MARK_TARGET", DEFAULT_TARGET))
    @template = options.fetch(:template, ENV["MARK_TEMPLATE"]?)
    @open = options.fetch(:open, ENV.fetch("MARK_OPEN", DEFAULT_OPEN))
    @keep = !!options.fetch(:keep, ENV["MARK_KEEP"]?)
    @keep_for = parse_keep_for(options.fetch(:keep_for, ENV.fetch("MARK_KEEP_FOR", DEFAULT_KEEP_FOR)))
  end

  def target_directory
    File.dirname(@target)
  end

  def open_command
    @open.sub("%", @target)
  end

  def keep_for_seconds
    @keep_for / 1000
  end
  
  def template_html
    if @template.nil? && File.exists?(DEFAULT_TEMPLATE)
      File.read(DEFAULT_TEMPLATE)
    elsif @template
      File.read(@template.not_nil!)
    else
      Template::DEFAULT_HTML
    end
  end

  def validate!
    raise OptionError.new("At least one source file must be given") unless @sources.size > 0
    raise OptionError.new("Invalid target directory: #{target_directory}") unless Dir.exists?(target_directory)
    files = @sources + [@template]
    files.compact.each do |file|
      raise OptionError.new("File does not exist: #{file}") unless File.exists?(file)
    end
  end

  private def parse_keep_for(keep_for : String)
    keep_for.to_u32
  rescue ArgumentError
    raise OptionError.new("Invalid keep for: #{keep_for}")
  end
end
