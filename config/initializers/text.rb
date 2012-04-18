require 'twilio-ruby'

def send_text(msg, to)
  text_account_sid = "ACd2540787b2e043139fdf123f84154a79"
  text_auth_token = "0a1eb64407d1cfc6a70175d2f73e7c3a"
  text_client = Twilio::REST::Client.new(text_account_sid, text_auth_token)

  text_client.account.sms.messages.create(
    :from => '+16504926713',
    :to => to,
    :body => msg
  )
end