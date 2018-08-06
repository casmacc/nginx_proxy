class Domain
  attr_reader :dom, :base

  def initialize(dom, base)
    @dom  = `export #{HOST_NAME}=#{base} ; echo #{dom}`.chomp
    @base = base
  end

  def to_s
    dom
  end
end

