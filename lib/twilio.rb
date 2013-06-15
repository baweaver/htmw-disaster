ACCOUNT_SID = ''
AUTH_TOKEN  = ''
OUR_NUMBER  = ''
 
client = Twilio::Rest::Client.new(ACCOUNT_SID, AUTH_TOKEN)

account = client.account

def smsSend(toNum, text)
  account.sms.messages.create(from: OUR_NUMBER, to: toNum, body: text)
end

def conference(numList)
  # to do
end
