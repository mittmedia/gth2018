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
    puts params.to_json
    to = verified_numbers[params[:to].to_i]
    from = verified_numbers[params[:from].to_i]
    message = params[:message]
    message_choice = params[:message_id].to_i
    if message_choice != -1
      message = tried_messages[message_choice][:message]
    end
    @sm = Sm.create!(to: to.to_json, from: from.to_json, message: message)
    @client = Twilio::REST::Client.new(account_sid, auth_token)
    @call = @client.calls.create(
      url: 'https://gth2018.herokuapp.com/message',
      to: to[:number],
      from: from[:number]
    )
    redirect_to @sm, notice: 'Sm was successfully created.'
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
