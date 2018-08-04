require 'yaml'

class Hash
  def deep_find(key, object=self, found=[])
    if object.respond_to?(:key?) && object.key?(key)
      found << object[key]
    end
    if object.is_a? Enumerable
      found << object.collect { |*a| deep_find(key, a.last) }
    end
    found.flatten.compact
  end
end

class Domain
  attr_reader :dom

  def initialize(dom)
    @dom = `echo #{dom}`.chomp
  end

  def has_conf?
    false
  end

  def has_cert?
    false
  end

  def to_s
    dom
  end
end

class DomainPresenter
  attr_reader :domain

  def initialize(domain)
    @domain = domain
  end

  def to_s
    "#{conf.ljust(4)} #{cert.ljust(4)} #{domain}"
  end

  private

  def conf
    domain.has_conf? ? "X" : "-"
  end

  def cert
    domain.has_cert? ? "X" : "-"
  end
end

BASE = File.expand_path("../", __dir__)
VOLS = BASE + "/volumes"
DCOM = BASE + "/docker-compose.yml"
YDAT = YAML::load_file(DCOM)
DOMS = YDAT.deep_find("VIRTUAL_HOST").map {|el| Domain.new(el)}
puts DOMS
