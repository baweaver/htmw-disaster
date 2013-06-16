require 'rubygems' # This line not needed for ruby > 1.8
require 'twilio-ruby'
require 'sqlite3'

#account_sid = "AC0a2ca9664ccb810dece8e55031b4db98"
#application_sid=""
#auth_token = "2556e2e74acf97b82033febf170532fe"
#twiliophone="8163993325"

account_sid = "	AC1173bb9e0015a2e9d8071da3d23e8fd2"
application_sid="AP26ff4abb8bf80873042f426fca12ba12"
auth_token = "e91f1b52005b605ab1174ca15cb0584d"
twiliophone="8165459240"


@client = Twilio::REST::Client.new account_sid, auth_token
@db = SQLite3::Database.open "../db/development.sqlite3"

#process inbound messages
@db.execute("update FONEFLARE set LASTSMSQUERY='2013-06-15 22:58:46 -0500'")
lastsmsquery=@db.get_first_value("select max(LASTSMSQUERY) from FONEFLARE limit 1")
rs=@client.account.sms.messages.list(:date_sent=>lastsmsquery)

if rs.count > 0
	rs.select! {|x| x.direction=="inbound"}
	rs.reject! {|x| Time.parse(x.date_sent).to_s()==lastsmsquery}
	rs.sort! {|x,y| x.date_sent<=>y.date_sent}

	lastsmsdate=Time.parse(rs[0].date_sent).to_s()
	@db.execute("update FONEFLARE set LASTSMSQUERY='"+lastsmsdate+"'")
		
	rs.each do |message|		
		def disableFlareAndResponderBuild(srcphone="")
			@db.execute "update FLARES set ACTIVE=0 where SRCPHONE='" + srcphone + "' and ACTIVE>=2"
			@db.execute "update RESPONDERS set ACTIVE=0 where SRCPHONE='" + srcphone + "' and ACTIVE>=2"
		end

		messagepending=true
		srcphone=message.from
		
		puts srcphone + " " + Time.parse(message.date_sent).to_s()
		
		md=/^stop$/i.match(message.body)
		if messagepending and md!=nil
			disableFlareAndResponderBuild srcphone
			puts "Stop"
			messagepending=false
		end
		
		md=/^flare new$/i.match(message.body)
		if messagepending and md!=nil
			disableFlareAndResponderBuild srcphone
			puts "Flare New"
			#@client.account.calls.create(:to=>"8166944335", :from=>twiliophone, :application_sid=>application_sid)
			messagepending=false
		end
		
		md=/^flare cancel f[0-9]+$/i.match(message.body)
		if messagepending and md!=nil
			disableFlareAndResponderBuild srcphone
			puts "Flare cancel"
			messagepending=false
		end
		
		md=/^flare call f[0-9]+$/i.match(message.body)
		if messagepending and md!=nil
			disableFlareAndResponderBuild srcphone
			puts "Flare conference call"
			messagepending=false
		end

		md=/^resp avail$/i.match(message.body)
		if messagepending and md!=nil
			disableFlareAndResponderBuild srcphone
			puts "Responder available"
			messagepending=false
		end

		md=/^resp quit$/i.match(message.body)
		if messagepending and md!=nil
			disableFlareAndResponderBuild srcphone
			puts "Responder quit"
			messagepending=false
		end
		
		md=/^resp f[0-9]+$/i.match(message.body)
		if messagepending and md!=nil
			disableFlareAndResponderBuild srcphone
			puts "Responder respond"
			messagepending=false
		end
		
		md=/^resp call f[0-9]+$/i.match(message.body)
		if messagepending and md!=nil
			disableFlareAndResponderBuild srcphone
			puts "Responder call"
			
			messagepending=false
		end
		
		if messagepending
			fs=@db.get_first_value("select ACTIVE from FLARES where SRCPHONE='" + srcphone + "' and ACTIVE>=2")
			if fs!=nil
				case fs.to_s()
				when "2"
					fid=@db.get_first_value("select FLARE_ID from FLARES where SRCPHONE='" + srcphone + "' and ACTIVE=2")
					@client.account.sms.messages.create(:body=>"You have created a new FLARE ID=F"+fid.to_s(), :to=>srcphone, :from=>twiliophone)
					@client.account.sms.messages.create(:body=>"What is the zip code of your flare?", :to=>srcphone, :from=>twiliophone)
				when "3"
					@client.account.sms.messages.create(:body=>"What is the address or location code of your flare?", :to=>srcphone, :from=>twiliophone)
				when "4"
					@client.account.sms.messages.create(:body=>"What is the nature or category of your flare?", :to=>srcphone, :from=>twiliophone)
				when "5"
					@client.account.sms.messages.create(:body=>"Please enter a brief description of your flare.", :to=>srcphone, :from=>twiliophone)
				else
					disableFlareAndResponderBuild srcphone
					@client.account.sms.messages.create(:body=>"There was an error creating your flare.  Please reply with FLARE NEW to start over.", :to=>srcphone, :from=>twiliophone)
				end
				messagepending=false
			end
			rs=@db.get_first_value("select ACTIVE from RESPONDERS where SRCPHONE='" + srcphone + "' and ACTIVE>=2")
			if rs!=nil
				case rs.to_s()
					when "2"
					rid=@db.get_first_value("select RESPONDER_ID from RESPONDERS where SRCPHONE='" + srcphone + "' and ACTIVE=2")
					@client.account.sms.messages.create(:body=>"You have created a new RESPONDER ID=R"+fid.to_s(), :to=>srcphone, :from=>twiliophone)
					@client.account.sms.messages.create(:body=>"What is the zip code you can respond to?", :to=>srcphone, :from=>twiliophone)
					when "3"
					@client.account.sms.messages.create(:body=>"What is the radius in miles you can respond to?", :to=>srcphone, :from=>twiliophone)
					when "4"
					@client.account.sms.messages.create(:body=>"What is the category you can respond to?", :to=>srcphone, :from=>twiliophone)
				else
					disableFlareAndResponderBuild srcphone
					@client.account.sms.messages.create(:body=>"There was an error creating your flare.  Please reply with FLARE NEW to start over.", :to=>srcphone, :from=>twiliophone)
				end
				messagepending=false
			end
		end

		if messagepending and false 
			body="ORIGINATOR: HELP,FLARE NEW,FLARE CANCEL [FID],FLARE CALL [FID]\nRESPONDER: RESP AVAIL [ZIP RADIUS],RESP QUIT,RESP [FID},RESP CALL [FID]"
			@client.account.sms.messages.create(:body=>body, :to=>srcphone, :from=>twiliophone)
			
			body="STOP to cancel all messages"
			@client.account.sms.messages.create(:body=>body, :to=>srcphone, :from=>twiliophone)

			messagepending=false
		end
	end
end

#process outbound messages
sql="
	select	a.flare_id,
			a.srcphone as flare_srcphone,
			c.description as flare_category,
			a.zip as flare_zip,
			a.location as flare_location,
			a.description as flare_description,
			a.created_dt as flare_created_dt,
			b.responder_id,
			b.srcphone as responder_srcphone
	from 	FLARES as a
			inner join RESPONDERS as b
				on b.zip=a.zip
					and (b.category=a.category or b.category=0)
					and '"+(Time.now-15*60*60).to_s()+"'>(select max(created_dt) from COMMUNICATIONS as e where e.responder_id=b.responder_id)
					and b.active=1
			inner join CATEGORIES as c
				on c.category_id=a.category
	where	a.active=1
			and not exists (select * from COMMUNICATIONS as d where d.flare_id=a.flare_id and d.responder_id=b.responder_id)
	order by b.srcphone,
			a.created_dt desc
	"
rs=@db.execute sql
resp_srcphone=""
rs.each do |row|
	if rs["responder_srcphone"]!=resp_srcphone
		resp_count=0
		resp_srcphone=rs["responder_srcphone"]
	end
	
	if resp_count<5
		@client.account.sms.messages.create("A "+rs["Category"].to_s()+" flare has been sent in your area. FlareID="+rs["flare_id"].to_s()+".")
		@client.account.sms.messages.create(rs["flare_description"])
		db.execute "insert into COMMUNICATIONS (flare_id, responder_id, created_dt) values ("+rs["flare_id"].to_s()+","+rs["responder_id"].to_s(),Time.now.to_s()+")"
		resp_count=resp_count+1
	end
end