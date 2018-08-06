require 'open-uri'

class Domain
  attr_reader :dom, :base

  def initialize(dom, base)
    @dom  = `export #{HOST_NAME}=#{base} ; echo #{dom}`.chomp
    @base = base
  end

  def pingable?
    system("ping -c 1 #{dom} > /dev/null 2>&1")
  end

  def getable?
    system("wget #{dom} -O /dev/null > /dev/null 2>&1")
  end

  def htmlable?
    base = "/.well-known/acme-challenge/test_file.html"
    path = File.expand_path(VOLS + "/../volumes/html" + base)
    text = Time.now.to_s
    File.open(path, "w") {|f| f.puts Time.now}
    getable? && open("http://#{dom}#{base}").read.chomp == text
  end

  def to_s
    dom
  end
end

