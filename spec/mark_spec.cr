require "./spec_helper"

describe Mark do
  it "sets VERSION" do
    Mark::VERSION.empty?.should eq(false)
  end
end
