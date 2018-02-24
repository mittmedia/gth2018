class SmsController < ApplicationController
  before_action :set_sm, only: [:show, :edit, :update, :destroy]
  protect_from_forgery :except => [:message]

  # GET /sms
  # GET /sms.json
  def index
    @sms = Sm.all

  end

  # GET /sms/1
  # GET /sms/1.json
  def show
  end

  # GET /sms/new
  def new
    @contacts = verified_numbers
    @messages = tried_messages
    @sm = Sm.new
  end

  # GET /sms/1/edit
  def edit
  end

  # POST /sms
  # POST /sms.json
  def create
    to = verified_numbers[params[:to].to_i]
    from = verified_numbers[params[:from].to_i]
    message = params[:message]
    message_choice = params[:message_id].to_i
    if message_choice != -1
      message = tried_messages[message_choice][:message]
    end
    is_hate = hate_speach?(message)
    @sm = Sm.create!(to: to.to_json, from: from.to_json, message: message, is_hate: is_hate)
    if is_hate
      #   @call = @client.calls.create(
      #     url: 'https://gth2018.herokuapp.com/message',
      #     to: to[:number],
      #     from: from[:number]
      #   )
      @client = Twilio::REST::Client.new(account_sid, auth_token)
      @message = @client.messages.create(
        from: '+46765193283',
        to: from[:number],
        body: 'ExposeBot has detected a threatful message from you and saved it as evidence for future police investigations. https://gth2018.herokuapp.com/no_abuse.jpg',
      )
      @message = @client.messages.create(
        from: '+46765193283',
        to: to[:number],
        body: 'ExposeBot has detected a threatful message to you and asked the sender to cease and desist, we have also saved this on our servers in case you want to open a police case.',
      )
    end
    redirect_to @sm, notice: 'SMS was successfully analyzed and stored.'
  end

  # PATCH/PUT /sms/1
  # PATCH/PUT /sms/1.json
  def update
    respond_to do |format|
      if @sm.update(sm_params)
        format.html { redirect_to @sm, notice: 'Sm was successfully updated.' }
        format.json { render :show, status: :ok, location: @sm }
      else
        format.html { render :edit }
        format.json { render json: @sm.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sms/1
  # DELETE /sms/1.json
  def destroy
    @sm.destroy
    respond_to do |format|
      format.html { redirect_to sms_url, notice: 'Sm was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def message
    render :layout => false
  end

  def hate_speach? (message)
    response = HTTParty.post(
      'http://lag8.goodtechhack.se:1337/sentence/',
      body: {sentence: message}
    )
    response.parsed_response.downcase == 'true'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sm
      @sm = Sm.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sm_params
      params.require(:sm).permit(:form)
    end
end
