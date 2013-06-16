require 'rubygems' # This line not needed for ruby > 1.8
require 'twilio-ruby'
require 'sqlite3'

account_sid = 'AC0a2ca9664ccb810dece8e55031b4db98'
auth_token = '2556e2e74acf97b82033febf170532fe'
client = Twilio::REST::Client.new account_sid, auth_token
db = SQLite3::Database.open "../db/development.sqlite3"

db.execute("update FONEFLARE set LASTSMSQUERY='2013-06-15 16:17:00 -0500'")
lastsmsquery=db.get_first_value("select max(LASTSMSQUERY) from FONEFLARE limit 1")
rs=client.account.sms.messages.list(:date_sent=>lastsmsquery)

if rs.count > 0
	lastsmsdate=Time.parse(rs[0].date_sent).to_s()
	
	db.execute("update FONEFLARE set LASTSMSQUERY='"+lastsmsdate+"'")
	
	rs.select! {|x| x.direction=="inbound"}
	rs.sort! {|x,y| x.date_sent<=>y.date_sent}

	rs.each do |message|
		if message!=rs[0]
			md=/^helpme/i.match(message.body)
			if md!=nil
				puts "HelpMe"
			end

			md=/^stop/i.match(message.body)
			if md!=nil
				puts "Stop"
			end
			
			md=/^flare new/i.match(message.body)
			if md!=nil
				puts "Flare New"
			end
			
			md=/^flare cancel/i.match(message.body)
			if md!=nil
				puts "Flare cancel"
			end
			
			md=/^flare call/i.match(message.body)
			if md!=nil
				puts "Flare conference call"
			end

			md=/^resp avail/i.match(message.body)
			if md!=nil
				puts "Responder available"
			end

			md=/^resp quit/i.match(message.body)
			if md!=nil
				puts "Responder quit"
			end
			
			md=/^resp f[0-9]+/i.match(message.body)
			if md!=nil
				puts "Responder respond"
			end
			
			md=/^resp call/i.match(message.body)
			if md!=nil
				puts "Responder call"
			end

			puts message.direction + "-" + Time.parse(message.date_sent).to_s() + "-" + message.body
		end
	end
end

