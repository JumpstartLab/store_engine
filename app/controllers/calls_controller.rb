class CallsController < ApplicationController
  def create
    @account_sid = 'AC6b6a26f6965e4e9384496b548d7d7d91'
    @auth_token = '04db0e311c86bd9dcdbd619a70665b8b'

    # set up a client to talk to the Twilio REST API
    @client = Twilio::REST::Client.new(@account_sid, @auth_token)
    @account = @client.account
    # @message = @account.sms.messages.create(:to=>"+15862914303", :from=>"+14155992671",
    #                                        :body=>"Testing")
    @call = @account.calls.create({:from => '5866904041', :to => '5862914303', :url => new_call_url })
    puts @message
    render call_path(1)
  end

  def new
    render :layout => "empty"
  end

  def show
  end
end
