require 'spec_helper'

# For ease of use a library directory will no be used.
# Instead the commit-msg script will be called and the output parsed.

describe "commit-msg" do
  it "should abort if not given a filename as the first arg" do
    stdout, stderr, status = run_commit_msg
    expect(stderr.first).to match(/missing commit log message/)
    expect(stdout).to eq []
  end
end
