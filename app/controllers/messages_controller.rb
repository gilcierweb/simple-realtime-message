class MessagesController < ApplicationController
  before_action :set_message, only: [:show, :edit, :update, :destroy]
  before_action :count_message
  # GET /messages
  # GET /messages.json
  def index
    @messages = Message.all
  end

  # GET /messages/1
  # GET /messages/1.json
  def show
  end

  # GET /messages/new
  def new
    @message = Message.new
  end

  # GET /messages/1/edit
  def edit
  end

  # POST /messages
  # POST /messages.json
  def create

    @message = Message.new(message_params)

    respond_to do |format|
      if @message.save
        # format.html { redirect_to @message, notice: t('message.create') }
        # @message['new_count_message']= @message.length.to_s
        # format.json { render :show, status: :created, location: @message}
        count_messages = Message.count_message
        format.json { render :json=> {status: :created, location: @message, new_count_message: count_messages,  :include => {:port =>222}}}

      else
        format.html { render :new }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /messages/1
  # PATCH/PUT /messages/1.json
  def update
    respond_to do |format|
      if @message.update(message_params)
        format.html { redirect_to @message, notice: t('message.update') }
        format.json { render :show, status: :ok, location: @message.merge(:success=> true) }
      else
        format.html { render :edit }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /messages/1
  # DELETE /messages/1.json
  def destroy
    @message.destroy
    respond_to do |format|
      format.html { redirect_to messages_url, notice:  t('message.destroy') }
      format.json { head :no_content }
    end
  end

  def updateSeen
    # if @message.update(message_params)
      respond_to do |format|
        # format.html { redirect_to messages_url, notice: 'Message was successfully destroyed.' }
        arr['update_count_message'] = Message.CountNewMessage
        arr['update_count_message'] = Message.CountNewMessage
        format.json { render :show, status: :ok, location: @message, update_count_message: 2 }
      end
    # end
  end

  private

  def count_message
    @count_messages = Message.all.length.to_s
  end
  # Use callbacks to share common setup or constraints between actions.
  def set_message
    @message = Message.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def message_params
    params.require(:message).permit(:name, :email, :subject, :message, :seen)
  end
end
