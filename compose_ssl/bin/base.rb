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

BASE = File.expand_path("../", __dir__)
VOLS = BASE + "/volumes"
DCOM = BASE + "/docker-compose.yml"
YDAT = YAML::load_file(DCOM)
DOMS = YDAT.deep_find("VIRTUAL_HOST")
puts DOMS
