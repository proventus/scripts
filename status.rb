require 'net/http'
require 'net/smtp'

def check_http host, path
  http = Net::HTTP.new(host)
  http.open_timeout = 20
  http.read_timeout = 20
  resp, data = http.get path, nil
  unless resp.code == "200"
    send_mail "Received code #{resp.code} from #{host}"
  end
end

def send_mail subject
  from = "support@proventustechnologies.com"

  msg = <<END_OF_MESSAGE
From: #{from}
To: #{from}
Subject: #{subject}
END_OF_MESSAGE
  Net::SMTP.start('proventustechnologies.com') do |smtp|
    smtp.send_message msg, from, "abodner@proventustechnologies.com",
	"akramnik@proventustechnologies.com"
  end
end

check_http 'account.proventustechnologies.com', '/portal/'
check_http 'lb1.proventustechnologies.com', '/api/json'
check_http 'lb2.proventustechnologies.com', '/api/json'
