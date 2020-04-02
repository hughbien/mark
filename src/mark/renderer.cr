require "../mark"
require "file_utils"
require "common_marker"

class Mark::Renderer
  EXTENSIONS = ["table", "strikethrough", "autolink", "tagfilter", "tasklist"]
  OPTIONS = ["unsafe"]

  def initialize(@opts : Options)
  end

  def render
    md = @opts.sources.map { |source| File.read(source) }.join("\n")
    html = render_markdown(md)
    FileUtils.mkdir_p(@opts.target_directory)
    File.write(@opts.target, html)
  end

  private def render_markdown(markdown : String)
    CommonMarker.new(
      markdown,
      options: OPTIONS,
      extensions: EXTENSIONS
    ).to_html
  end
end
