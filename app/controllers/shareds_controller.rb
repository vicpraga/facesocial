class SharedsController < ApplicationController
  before_action :set_shared, only: [:show, :edit, :update, :destroy]

  # GET /shareds
  # GET /shareds.json
  def index
    @user = User.find_by(name: session[:user])
    @shareds = Shared.where(user_id: @user.id)
  end

  # GET /shareds/1
  # GET /shareds/1.json
  def show
  end

  # GET /shareds/new
  def new
    @shared = Shared.new
  end

  # GET /shareds/1/edit
  def edit
  end

  # POST /shareds
  # POST /shareds.json
  def create
    @message_id = params[:message_id]
    @user_id = params[:user_id]
    @shared = Shared.new
    @shared.user = User.find(@user_id)
    @shared.message = Message.find(@message_id)
    @shared2 = Shared.find_by(message_id: @message_id, user_id: @user_id)

    @messageShared = Message.new
    @messageShared.texto=@shared.message.texto
    @messageShared.user = User.find(@user_id)

    @messageShared2 = Message.find_by(texto: @messageShared.texto, user_id:@user_id)

    if @shared2 == nil
      respond_to do |format|     
        if @shared.save
          @messageShared.save
          format.html { redirect_to @shared, notice: 'Shared was successfully created.' }
          format.json { render :show, status: :created, location: @shared }
        else
          format.html { render :new }
          format.json { render json: @shared.errors, status: :unprocessable_entity }
        end
      end
    else 
      @messageShared2.destroy
      @shared2.destroy
      redirect_to root_path, notice: "Now you are not sharing this post"
    end 

  end

  # PATCH/PUT /shareds/1
  # PATCH/PUT /shareds/1.json
  def update
    respond_to do |format|
      if @shared.update(shared_params)
        format.html { redirect_to @shared, notice: 'Shared was successfully updated.' }
        format.json { render :show, status: :ok, location: @shared }
      else
        format.html { render :edit }
        format.json { render json: @shared.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /shareds/1
  # DELETE /shareds/1.json
  def destroy
    @shared.destroy
    respond_to do |format|
      format.html { redirect_to shareds_url, notice: 'Shared was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_shared
      @shared = Shared.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def shared_params
      params.require(:shared).permit(:user_id, :message_id)
    end
end
