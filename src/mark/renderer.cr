require "../mark"
require "file_utils"
require "common_marker"

# The markdown to HTML pipeline occurs here:
# 1. reads markdown from source file(s)
# 2. converts to HTML with template
# 3. writes to target file
#
# Example usage:
# ```
# options = Mark::Options.new(["source.md"], {})
# renderer = Mark::Renderer.new(options)
# renderer.render
# ```
class Mark::Renderer
  EXTENSIONS = ["table", "strikethrough", "autolink", "tagfilter", "tasklist"]
  OPTIONS = ["unsafe"]

  HIGHLIGHT_HEAD = "<link rel=\"stylesheet\" href=\"https://cdnjs.cloudflare.com/ajax/libs/highlight.js/9.18.1/styles/darcula.min.css\">"
  HIGHLIGHT_SCRIPT = "<script src=\"https://cdnjs.cloudflare.com/ajax/libs/highlight.js/9.18.1/highlight.min.js\"></script><script>hljs.initHighlightingOnLoad();</script>"

  def initialize(@opts : Options)
  end

  # Reads markdown from source file(s). Writes HTML to target file.
  def render
    md = @opts.sources.map { |source| File.read(source) }.join("\n")
    html = sub_head(@opts.template_html)
    html = sub_script(html)
    html = sub_body(html, render_markdown(md))

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

  private def sub_body(html, body)
    html.sub("\#{BODY}", body)
  end

  private def sub_head(html)
    head = @opts.highlight ? HIGHLIGHT_HEAD : ""
    html.sub("\#{HEAD}", head)
  end

  private def sub_script(html)
    script = @opts.highlight ? HIGHLIGHT_SCRIPT : ""
    html.sub("\#{SCRIPT}", script)
  end
end
