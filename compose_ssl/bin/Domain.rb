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
    text = Time.now.to_s

    path = "/.well-known/acme-challenge"
    file = "/test_#{dom.gsub('.','_')}.html"

    lbase = File.expand_path(VOLS + "/html")
    hbase = "http://#{dom}"

    lpath = lbase + path
    lfile = lbase + path + file
    hfile = hbase + path + file

    system "mkdir -p #{lpath}"

    File.open(lfile, "w") {|f| f.puts(text)}

    getable? && path_text(hfile) == text
  end

  def to_s
    dom
  end

  private

  def path_text(url)
    begin
      open(url).read.chomp
    rescue
      "ERROR"
    end
  end
end

