require "../spec_helper"

describe Mark::Options do
  describe "#sources" do
    it "sets via initialization" do
      options = build_options("/path/to/source.md")
      options.sources.should eq(["/path/to/source.md"])
    end
  end

  describe "#target" do
    it "sets via initialization" do
      options = build_options({ :target => "/path/to/target.html" })
      options.target.should eq("/path/to/target.html")
    end

    it "sets via ENV var" do
      ENV["MARK_TARGET"] = "/path/to/target_from_env.html"
      options = build_options
      options.target.should eq("/path/to/target_from_env.html")
      ENV.delete("MARK_TARGET")
    end

    it "sets to default" do
      options = build_options
      options.target.should eq(Mark::Options::DEFAULT_TARGET)
    end
  end

  describe "#target_directory" do
    it "returns directory of target path" do
      options = build_options({ :target => "/path/to/target.html" })
      options.target_directory.should eq("/path/to")
    end
  end

  describe "#open_command" do
    it "sets via initialization" do
      options = build_options({ :open => "custom_open_cmd" })
      options.open_command.should eq("custom_open_cmd")
    end

    it "sets via ENV var" do
      ENV["MARK_OPEN"] = "custom_open_cmd_from_env"
      options = build_options
      options.open_command.should eq("custom_open_cmd_from_env")
      ENV.delete("MARK_OPEN")
    end

    it "sets to default" do
      options = build_options({ :target => "%" })
      options.open_command.should eq(Mark::Options::DEFAULT_OPEN)
    end

    it "replaces % placeholder with target" do
      options = build_options({ :target => "/path/to/target.html" })
      options.open_command.should eq("open /path/to/target.html")
    end
  end

  describe "#keep_for_seconds" do
    it "sets via initialization" do
      options = build_options({ :keep_for => "1000" })
      options.keep_for_seconds.should eq(1)
    end

    it "sets via ENV var" do
      ENV["MARK_KEEP_FOR"] = "2000"
      options = build_options
      options.keep_for_seconds.should eq(2)
      ENV.delete("MARK_KEEP_FOR")
    end

    it "raises error on invalid format" do
      expect_raises(Mark::Options::OptionError, "Invalid keep for: invalid-int") do
        build_options({ :keep_for => "invalid-int" })
      end
    end
  end

  describe "#template_html" do
    it "reads from initialization" do
      template = setup_template("<html></html>")
      options = build_options({ :template => template.path })
      options.template_html.should eq("<html></html>")
      template.delete
    end

    it "reads from ENV var" do
      template = setup_template("from_env_var")
      ENV["MARK_TEMPLATE"] = template.path
      options = build_options
      options.template_html.should eq("from_env_var")
      template.delete
      ENV.delete("MARK_TEMPLATE")
    end

    it "sets to Template::DEFAULT_HTML as last resort" do
      options = build_options
      options.template_html.should eq(Mark::Template::DEFAULT_HTML)
    end
  end

  describe "#validate!" do
    it "raises when no source files are given" do
      options = build_options(Array(String).new)
      expect_raises(Mark::Options::OptionError, "At least one source file must be given") do
        options.validate!
      end
    end

    it "raises when source file does not exist" do
      source = setup_source
      options = build_options([source.path, "/path/to/non-existing/file.md"])
      expect_raises(Mark::Options::OptionError, "File does not exist: /path/to/non-existing/file.md") do
        options.validate!
      end
      source.delete
    end

    it "raises when target directory does not exist" do
      source = setup_source
      options = build_options(source.path, { :target => "/path/to/non-existing/target.html" })
      expect_raises(Mark::Options::OptionError, "Invalid target directory: /path/to/non-existing") do
        options.validate!
      end
      source.delete
    end

    it "raises when template file does not exist" do
      source = setup_source
      options = build_options([source.path], { :template => "/path/to/non-existing/template.html" })
      expect_raises(Mark::Options::OptionError, "File does not exist: /path/to/non-existing/template.html") do
        options.validate!
      end
      source.delete
    end
  end
end
