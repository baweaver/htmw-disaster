require 'rubygems' # This line not needed for ruby > 1.8
require 'twilio-ruby'

# Get your Account Sid and Auth Token from twilio.com/user/account
account_sid = 'AC0a2ca9664ccb810dece8e55031b4db98'
auth_token = '2556e2e74acf97b82033febf170532fe'
@client = Twilio::REST::Client.new account_sid, auth_token

# Loop over messages and print out a property for each one
@client.account.sms.messages.list.each do |message|
	puts message.body
	puts message.from
	puts message.to
	puts message.price

end
