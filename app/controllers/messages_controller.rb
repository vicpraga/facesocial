class MessagesController < ApplicationController
  before_action :set_message, only: [:show, :edit, :update, :destroy]

  # GET /messages
  # GET /messages.json
  def index
    if !session[:user]
      redirect_to new_session_path
    else
      @user = User.find_by(name: session[:user])
      @friends = Friend.where("(userA_id = ? or userB_id = ?) and estado = ?",@user.id,@user.id,true)
      @messages = []
      @friends.each do |friend|
        if friend.userA.name == session[:user]
          @messages_aux = Message.where("user_id = ?", friend.userB.id)
          if @messages_aux != nil
            @messages.concat(@messages_aux)
          end
        else
          @messages_aux = Message.where("user_id = ?", friend.userA.id)
          if @messages_aux != nil
            @messages.concat(@messages_aux)
          end
        end
      end    
      @messages_aux = Message.where("user_id = ? ",@user.id)
      if @messages_aux != nil
        @messages.concat(@messages_aux)
      end

    end
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
    @user = User.find_by(name: session[:user])
    @message = Message.new(message_params)
    @message.user = User.find_by(name: session[:user])

    respond_to do |format|
      if @message.save
        format.html { redirect_to root_path, notice: 'Message was successfully created.' }
        format.json { render :show, status: :created, location: @message }
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
        format.html { redirect_to @message, notice: 'Message was successfully updated.' }
        format.json { render :show, status: :ok, location: @message }
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
      format.html { redirect_to messages_url, notice: 'Message was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_message
      @message = Message.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def message_params
      params.require(:message).permit(:texto, :user_id, :avatar)
    end
end
