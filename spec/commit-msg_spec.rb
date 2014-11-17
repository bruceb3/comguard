require 'spec_helper'

# For ease of use a library directory will no be used.
# Instead the commit-msg script will be called and the output parsed.

describe "commit-msg" do
  it "should write out the commit messages log" do
    input_file = make_file_with('feat(scope): message message')
    stdout, stderr, status = run_commit_msg args: input_file
    expect(status.exitstatus).to eq 0
    expect(cat(input_file).first).to match(/message message/)
  end

  it "should abort if not given a filename as the first arg" do
    stdout, stderr, status = run_commit_msg
    expect(stderr.first).to match(/MISSING COMMIT LOG MESSAGE/)
    expect(status.exitstatus).to eq 1
  end

  it "should convert uppercase to lower case on the first line" do
    input_file = make_file_with('feat(scope): Message Message')
    stdout, stderr, status = run_commit_msg args: input_file
    expect(cat(input_file).first).to match(/message message/)
    expect(status.exitstatus).to eq 0
  end

  it "should fail when given invalid type" do
    input_file = make_file_with('badtype(scope): message message')
    stdout, stderr, status = run_commit_msg args: input_file
    expect(status.exitstatus).to eq 1
    expect(stderr.first).to match(/INVALID COMMIT TYPE/)
  end

  it "should work when given a valid type" do
    input_file = make_file_with('feat(scope): good message')
    stdout, stderr, status = run_commit_msg args: input_file
    expect(status.exitstatus).to eq 0
  end

  it "should work when scope has a hyphen" do
    input_file = make_file_with('feat(with-hyphen): good message')
    stdout, stderr, status = run_commit_msg args: input_file
    expect(status.exitstatus).to eq 0
  end

  it "needs to display the valid types separated by spaces" do
    input_file = make_file_with('this will fail')
    stdout, stderr, status = run_commit_msg args: input_file
    expect(status.exitstatus).to eq 1
    expect(stderr[1]).to match(/ feat fix docs style ref test chore/)
  end
end
