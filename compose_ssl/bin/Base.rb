require 'yaml'

require_relative "./Domain"

HOST_NAME = "BASE_HOSTNAME"
MAIL_NAME = "LE_MAIL"

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

def read_value(regex)
  env_file = File.expand_path("../env", __dir__)
  return nil unless File.exist?(env_file)
  File.readlines(env_file).map do |line|
    line.scan(regex).empty? ? nil : line.chomp.strip.split("=").last
  end.drop_while(&:nil?).first
end

def read_host
  @host ||= read_value(Regexp.new(HOST_NAME))
end

def read_mail
  @mail ||= read_value(Regexp.new(MAIL_NAME))
end

HOST = ENV[HOST_NAME] || read_host || "myhost.com"
MAIL = ENV[MAIL_NAME] || read_mail

BASE = File.expand_path("../", __dir__)
VOLS = BASE + "/volumes"
DCOM = BASE + "/docker-compose.yml"
YDAT = YAML::load_file(DCOM)
DOMS = YDAT.deep_find("VIRTUAL_HOST").map {|el| Domain.new(el, HOST)}

CERT_PATH = VOLS + "/certs"
