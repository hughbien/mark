require "../mark"

class Mark::Options
  DEFAULT_TARGET = File.join(ENV["HOME"], ".mark", "index.html")
  DEFAULT_OPEN = "open %"

  getter :sources, :target

  def initialize(@sources : Array(String))
    @target = DEFAULT_TARGET
    @open = DEFAULT_OPEN
  end

  def target_directory
    File.dirname(@target)
  end

  def open_command
    @open.sub("%", @target)
  end
end
