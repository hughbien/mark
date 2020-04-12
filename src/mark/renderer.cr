require "../mark"
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
  FRONTMATTER_HEAD = /^---\s*[\r\n]+/
  FRONTMATTER_TAIL = /[\r\n]+---\s*[\r\n]+/

  def initialize(@opts : Options)
  end

  # Reads markdown from source file(s). Writes HTML to target file.
  def render
    md = @opts.sources.map { |source| format_frontmatter(File.read(source)) }.join("\n")
    html = @opts.template_html.sub("\#{BODY}", render_markdown(md))
    File.write(@opts.target, html)
  end

  # Formats front-matter YAML as a code block
  private def format_frontmatter(source : String)
    if source =~ FRONTMATTER_HEAD
      source.sub(FRONTMATTER_HEAD, "```yaml\n").sub(FRONTMATTER_TAIL, "\n```\n")
    else
      source
    end
  end

  private def render_markdown(markdown : String)
    CommonMarker.new(
      markdown,
      options: OPTIONS,
      extensions: EXTENSIONS
    ).to_html
  end
end
