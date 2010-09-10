require File.join('lib', 'dynaru')
require 'excon'

def with_server(&block)
  pid = Process.fork do
    Dynaru::Server.run
  end
  loop do
    sleep(1)
    begin
      Excon.get('http://localhost:9292/api/foo')
      break
    rescue
    end
  end
  yield
ensure
  Process.kill(9, pid)
end

with_server do
  p Excon.get('http://localhost:9292/api/foo').body
  p Excon.put('http://localhost:9292/api/foo', :body => 'bar').status
  p Excon.get('http://localhost:9292/api/foo').body
end
