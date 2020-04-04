require "../spec_helper"

describe Mark::Template do
  describe "DEFAULT_HTML" do
    it "has a doctype" do
      Mark::Template::DEFAULT_HTML.should contain("<!doctype html>")
    end

    it "has a body tag" do
      Mark::Template::DEFAULT_HTML.should contain("<body>")
      Mark::Template::DEFAULT_HTML.should contain("</body>")
    end

    it "has a body placeholder" do
      Mark::Template::DEFAULT_HTML.should contain("\#{BODY}")
    end
  end
end
