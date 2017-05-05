class SessionsController < ApplicationController
  # GET /sessions/new
  def new
    if session[:user]
      redirect_to messages_path
    else
      @messages = Message.all
    end
  end

  # POST /sessions
  # POST /sessions.json
  def create
    @user = User.find_by name: params[:username]
    if !@user
      flash.now.alert = "username #{params[:username]} is invalid"
      render :new
    elsif @user.password != params[:password]
      flash.now.alert = "password #{params[:password]} is incorrect"
      render :new
    else
      session[:user] = @user.name
      redirect_to messages_path, :notice => "Logged in!"
    end
  end

  # DELETE /sessions/1
  # DELETE /sessions/1.json
  def destroy
    session[:user] = nil
    redirect_to login_path, :notice => "Logged out!"
  end

end
