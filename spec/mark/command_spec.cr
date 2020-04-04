require "../spec_helper"
require "uuid"

describe Mark::Command do
  describe "#run" do
    it "prints help on --help" do
      io = String::Builder.new
      Mark::Command.new(["-h"], io).run
      io.to_s.should contain("Usage: mark")
    end

    it "prints version on --version" do
      io = String::Builder.new
      Mark::Command.new(["-v"], io).run
      io.to_s.should contain(Mark::VERSION)
    end

    it "prints error on invalid option" do
      io = String::Builder.new
      Mark::Command.new(["--nope"], io).run
      io.to_s.should contain("Invalid option: --nope")
    end

    it "prints error on option error" do
      io = String::Builder.new
      Mark::Command.new(Array(String).new, io).run
      io.to_s.should contain("At least one source file must be given")
    end

    it "renders markdown to HTML" do
      io = String::Builder.new
      uuid = UUID.random
      source = setup_source(uuid)
      target = setup_tempfile("")
      io_target = setup_tempfile("")

      Mark::Command.new(["-t", target.path, "-o", "cat % > #{io_target.path}", source.path], io).run
      File.read(io_target.path).should contain(uuid.to_s)
      File.exists?(target.path).should be_false

      source.delete
      io_target.delete
    end
  end
end
