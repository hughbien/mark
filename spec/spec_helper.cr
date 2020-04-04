require "spec"
require "../src/mark"

def setup_source(markdown = "*markdown*")
  setup_tempfile(markdown)
end

def setup_template(html = "<html>\#{BODY}</html>")
  setup_tempfile(html)
end

def setup_tempfile(content)
  file = File.tempfile
  File.write(file.path, content)
  file
end

def build_options(options = Hash(Symbol, String).new)
  build_options("source.md", options)
end

def build_options(source : String, options = Hash(Symbol, String).new)
  build_options([source], options)
end

def build_options(sources : Array(String), options = Hash(Symbol, String).new)
  Mark::Options.new(sources, options)
end

# capture IO stream for testing
class StringIO < IO
  def initialize
    @lines = Array(String).new
  end

  def puts(str)
    puts str.to_s
    @lines << str.to_s
  end

  def read(slice : Bytes)
    read
  end

  def read
    @lines.join("\n")
  end

  def write(slice : Bytes) : Nil
    nil
  end
end
