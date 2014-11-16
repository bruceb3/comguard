
require 'tempfile'

def cat filename
  File.readlines(filename).map! {|l| l.chomp! }
end

def run_commit_msg cmd: './commit-msg', args: []
  stdoutf, stderrf = Tempfile.new('commit-msg.stdout').path, Tempfile.new('commit-msg.stderr').path
  pid = fork
  if pid == nil
    $stdout.reopen stdoutf
    $stderr.reopen stderrf
    exec cmd, *args
    abort "exec failed"
  else
    Process.waitpid pid
    status = $?
  end
  return cat(stdoutf), cat(stderrf), status
end

def make_file_with *lines
  fh = Tempfile.new('commit-msg-contents')
  lines.each {|l| fh.puts l}
  fh.close
  fh.path
end
