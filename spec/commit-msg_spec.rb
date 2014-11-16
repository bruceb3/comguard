require 'spec_helper'

# For ease of use a library directory will no be used.
# Instead the commit-msg script will be called and the output parsed.

describe "commit-msg" do
  it "should run but have no output" do
    stdout, stderr = run_commit_msg
    expect(stdout).to eq []
    expect(stderr).to eq []
  end
end
