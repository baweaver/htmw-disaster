ACCOUNT_SID = 'AC0a2ca9664ccb810dece8e55031b4db98'
AUTH_TOKEN  = '2556e2e74acf97b82033febf170532fe'
OUR_NUMBER  = '816-399-3325'
 
client = Twilio::Rest::Client.new(ACCOUNT_SID, AUTH_TOKEN)

account = client.account

def smsSend(toNum, text)
  account.sms.messages.create(from: OUR_NUMBER, to: toNum, body: text)
end

def conference(numList)
  # to do
end
