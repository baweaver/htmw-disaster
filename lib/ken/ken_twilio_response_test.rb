require 'rubygems' # This line not needed for ruby > 1.8
require 'twilio-ruby'

class foneflare_twilio
	@account_sid= 'AC0a2ca9664ccb810dece8e55031b4db98'
	@auth_token= '2556e2e74acf97b82033febf170532fe'
	@account_phone='8163993325'

	def initialize()
		@client = Twilio::REST::Client.new @account_sid, @auth_token
	end
	
	def get_messages()
		@client.account.sms.messages.list.each do |message_recv|
			puts message_recv.body
			puts message_recv.from
			puts message_recv.to
			puts message_recv.price
			
		if message_recv.body=="Helpme"
				message_send=@client.account.sms.messages.create(:body=>"hello world", :to=>message_recv.from, :from=>@account_phone)
			end
	end
end