class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    if !session[:user]
      redirect_to new_user_path
    else
      @user = User.find_by(name: session[:user])
      if (@user.admin == true)
        @users = User.all
      else 
        redirect_to root_path
      end
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
    @user_edit = User.find_by(id: @user.id)
  end

  # POST /users
  # POST /users.json
  def create
   @user = User.new(user_params)
   @user2 = User.find_by(name: @user.name)
   if @user2!=nil
      redirect_to new_user_path, :notice => "The username already exists"
    else
      if @user.save
        redirect_to messages_path, :notice => "Signed up!"
      else
        render :new
      end
  end

  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @messages = Message.where(user_id: @user.id)
    @messages.each do |message|
      message.destroy
    end 
    @likes = Like.where(user_id: @user.id)
    @likes.each do |like|
      like.destroy
    end

    @shareds = Shared.where(user_id: @user.id)
    @shareds.each do |shared|
      shared.destroy
    end
    @nots_sender = Notification.where(sender_id: @user.id)
    @nots_receiver = Notification.where(receiver_id: @user.id)

    @nots_sender.each do |sender|
      sender.destroy
    end

   @nots_receiver.each do |receiver|
      receiver.destroy
    end

    if @user.name == sessin[:user]
        @user.destroy
        session[:user] = nil
        respond_to do |format|
          format.html { redirect_to new_user_path, notice: 'User was successfully destroyed.' }
          format.json { head :no_content }
        end
    else
      @user.destroy
      respond_to do |format|
        format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
        format.json { head :no_content }
      end
    end
  
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :password, :admin)
    end
end
