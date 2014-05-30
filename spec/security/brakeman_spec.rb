require 'spec_helper'
require 'brakeman'

describe "Answers" do
  let(:checks) do
    tracker = Brakeman.run({
      app_path: '.',
      min_confidence: 0
    })
    checks = tracker.checks
    checks
  end
  
  it "returns zero high confidence controller warnings" do
    expect(checks.controller_warnings.length).to(eq(0), "Run `rake 'security:controllers[0]'` to debug.")
  end
  
  it "returns zero high confidence model warnings" do
    expect(checks.model_warnings.length).to(eq(0), "Run `rake security:models[0]` to debug.")
  end
  
  it "returns zero high confidence template warnings" do
    expect(checks.template_warnings.length).to(eq(0), "Run `rake 'security:template[0]'` to debug.")
  end

  it "returns zero high confidence other warnings" do
    expect(checks.other_warnings.length).to(eq(0), "Run `rake 'security:other[0]'` to debug.")
  end
end
