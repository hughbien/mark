require "../mark"

class Mark::Options
  DEFAULT_TARGET = File.join(ENV["HOME"], ".mark", "index.html")

  getter :sources, :target

  def initialize(@sources : Array(String))
    @target = DEFAULT_TARGET
  end

  def target_directory
    File.dirname(@target)
  end
end
