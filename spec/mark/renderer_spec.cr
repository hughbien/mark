require "../spec_helper"
require "uuid"

describe Mark::Renderer do
  it "reads markdown from source" do
    uuid = UUID.random
    source = setup_source(uuid)
    options = build_options(source.path)

    renderer = Mark::Renderer.new(options)
    renderer.render
    source.delete

    html = File.read(options.target)
    html.should contain(uuid.to_s)
  end

  it "reads markdown from multiple sources" do
    uuid1, uuid2 = UUID.random, UUID.random
    source1, source2 = setup_source(uuid1), setup_source(uuid2)
    options = build_options([source1.path, source2.path])

    renderer = Mark::Renderer.new(options)
    renderer.render
    [source1, source2].each(&.delete)

    html = File.read(options.target)
    html.should contain(uuid1.to_s)
    html.should contain(uuid2.to_s)
  end

  it "converts markdown to HTML" do
    source = setup_source("\n# header\n")
    options = build_options(source.path)

    renderer = Mark::Renderer.new(options)
    renderer.render
    source.delete

    html = File.read(options.target)
    html.should contain("<h1>header</h1>")
  end

  it "writes HTML to target" do
    uuid = UUID.random
    source = setup_source(uuid)
    target = File.tempfile
    options = build_options(source.path, { :target => target.path })

    renderer = Mark::Renderer.new(options)
    renderer.render

    html = File.read(target.path)
    html.should contain(uuid.to_s)

    source.delete
    target.delete
  end
end
