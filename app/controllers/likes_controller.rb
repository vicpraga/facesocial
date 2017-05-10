class LikesController < ApplicationController
  before_action :set_like, only: [:show, :edit, :update, :destroy]

  # GET /likes
  # GET /likes.json
  def index
    @likes = Like.all
    @user = User.find_by(name: session[:user])
  end

  # GET /likes/1
  # GET /likes/1.json
  def show
  end

  # GET /likes/new
  def new
    @like = Like.new
  end

  # GET /likes/1/edit
  def edit
  end

  # POST /likes
  # POST /likes.json
  def create
    @message_id = params[:message_id]
    @user_id = params[:user_id]
    @like = Like.new
    @like.message = Message.find(@message_id)
    @like.user = User.find(@user_id)
    @like2 = Like.find_by(message_id: @message_id, user_id: @user_id)
    @notification = Notification.new
    @notification.receiver = @like.message.user
    @notification.message = @like.message
    @notification.notificationType = "A user has given a like"
    @notification.sender = @like.user
    @notification2 = Notification.find_by(sender_id: @notification.sender.id, receiver_id: @notification.receiver.id, message_id: @notification.message.id)
    if @notification2 != nil
      @notification2.delete
    end    

    if @like2 == nil

        respond_to do |format|
        if @like.save
          if @notification.sender.name != @notification.receiver.name
            @notification.save
          end
          format.html { redirect_to root_path, notice: 'Like was successfully created.' }
          format.json { render :show, status: :created, location: @like }
        else
          format.html { render :new }
          format.json { render json: @like.errors, status: :unprocessable_entity }
        end
      end
    else
        @like2.destroy
        redirect_to root_path, notice: "You don't like this post"
    end
  end

  # PATCH/PUT /likes/1
  # PATCH/PUT /likes/1.json
  def update
    respond_to do |format|
      if @like.update(like_params)
        format.html { redirect_to root_path, notice: 'Like was successfully updated.' }
        format.json { render :show, status: :ok, location: @like }
      else
        format.html { render :edit }
        format.json { render json: @like.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /likes/1
  # DELETE /likes/1.json
  def destroy
    @like.destroy
    respond_to do |format|
      format.html { redirect_to likes_url, notice: 'Like was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_like
      @like = Like.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def like_params
      params.require(:like).permit(:message, :user_id, :message_id)
    end
end
