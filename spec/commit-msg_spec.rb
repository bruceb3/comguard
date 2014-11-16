require 'spec_helper'

# For ease of use a library directory will no be used.
# Instead the commit-msg script will be called and the output parsed.

describe "commit-msg" do
  it "should abort if not given a filename as the first arg" do
    stdout, stderr, status = run_commit_msg
    expect(stderr.first).to match(/missing commit log message/)
    expect(stdout).to eq []
  end

  it "should write out the commit messages log" do
    input_file = make_file_with('stuff')
    stdout, stderr = run_commit_msg
    expect(cat(input_file).first).to match(/stuff/)
  end

  it "should convert uppercase to lower case on the first line" do
    input_file = make_file_with('AAAAA')
    stdout, stderr = run_commit_msg args: input_file
    expect(cat(input_file).first).to match(/aaaaa/)
  end
end
