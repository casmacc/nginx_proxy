require_relative "./Base"

class Certbot
  attr_reader :dom

  def initialize(dom)
    @dom = dom
  end

  def dry_run
    str = "#{cmd} --dry-run"
    puts str
    puts system(str)
  end

  def run
    puts cmd
    puts system(cmd)
  end

  private

  def cmd
    email = MAIL
    "sudo certbot certonly --webroot --webroot-path=volumes/html --domain #{dom} --agree-tos --email #{email} --noninteractive"
  end
end
