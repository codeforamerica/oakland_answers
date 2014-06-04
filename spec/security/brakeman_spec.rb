require 'spec_helper'
require 'brakeman'

def format_warnings(warnings, type)
  warnings.join("\n") << "\n Run `rake 'security:#{type}[0]'` to debug."
end

describe "Answers" do
  let(:checks) do
    tracker = Brakeman.run({
      app_path: '.',
      min_confidence: 0
    })
    checks = tracker.checks
    checks
  end
  
  it "returns zero high confidence controller warnings", :security do
    brakeman_warnings = checks.controller_warnings
    expect(brakeman_warnings.length).to(eq(0), format_warnings(brakeman_warnings, "controllers"))
  end
  
  it "returns zero high confidence model warnings", :security do
    brakeman_warnings = checks.model_warnings
    expect(brakeman_warnings.length).to(eq(0), format_warnings(brakeman_warnings, "models"))
  end
  
  it "returns zero high confidence template warnings", :security do
    brakeman_warnings = checks.template_warnings
    expect(brakeman_warnings.length).to(eq(0), format_warnings(brakeman_warnings, "templates"))
  end

  it "returns zero high confidence other warnings", :security do
    brakeman_warnings = checks.warnings
    expect(brakeman_warnings.length).to(eq(0), format_warnings(brakeman_warnings, "other"))
  end
end
