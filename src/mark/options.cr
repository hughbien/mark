require "../mark"

class Mark::Options
  DEFAULT_TARGET = File.join(ENV["HOME"], ".mark", "index.html")
  DEFAULT_TEMPLATE = File.join(ENV["HOME"], ".mark", "template.html")
  DEFAULT_OPEN = "open %"

  class OptionError < Exception; end

  @sources : Array(String)
  @target : String
  @template : String?
  @open : String

  getter sources, target

  def initialize(@sources, options : Hash(Symbol, String))
    @target = options.fetch(:target, ENV.fetch("MARK_TARGET", DEFAULT_TARGET))
    @template = options.fetch(:template, ENV["MARK_TEMPLATE"]?)
    @open = options.fetch(:open, ENV.fetch("MARK_OPEN", DEFAULT_OPEN))
  end

  def target_directory
    File.dirname(@target)
  end

  def open_command
    @open.sub("%", @target)
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
    files = @sources + [@template]
    files.compact.each do |file|
      raise OptionError.new("File does not exist: #{file}") unless File.exists?(file)
    end
  end
end
