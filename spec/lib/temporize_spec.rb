require 'spec_helper'

describe Temporize do
  describe "#create" do
    it "does a Temporize post" do
      temporize = Temporize.new
      Temporize.should_receive(:post)
      temporize.do_reindex
    end
  end
end
