
require 'tempfile'

def cat filename
  File.readlines(filename).map! {|l| l.chomp! }
end

def run_commit_msg cmd='./commit-msg', args=[]
  begin
  stdoutf, stderrf = Tempfile.new('commit-msg.stdout').path, Tempfile.new('commit-msg.stderr').path
  pid = fork
  if pid == nil
    $stdout.reopen stdoutf
    $stdout.reopen stderrf
    exec cmd, *args
    abort "exec failed"
  else
    Process.waitpid pid
    status = $?
  end
  return cat(stdoutf), cat(stderrf)
  ensure
    File.unlink stdoutf
    File.unlink stderrf
  end
end
