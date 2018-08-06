class Certbot
  def initialize
  end

  def cmd(hostname, email)
    "sudo certbot certonly --webroot --webroot-path=volumes/html --domain #{hostname} --agree-tos --email #{email} --noninteractive"
  end
end
