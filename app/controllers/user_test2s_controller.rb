class UserTest2sController < ApplicationController
  before_action :set_user_test2, only: [:show, :edit, :update, :destroy]

  # GET /user_test2s
  # GET /user_test2s.json
  def index
    @user_test2s = UserTest2.all
  end

  # GET /user_test2s/1
  # GET /user_test2s/1.json
  def show
  end

  # GET /user_test2s/new
  def new
    @user_test2 = UserTest2.new
  end

  # GET /user_test2s/1/edit
  def edit
  end

  # POST /user_test2s
  # POST /user_test2s.json
  def create
    @user_test2 = UserTest2.new(user_test2_params)

    respond_to do |format|
      if @user_test2.save
        format.html { redirect_to @user_test2, notice: 'User test2 was successfully created.' }
        format.json { render :show, status: :created, location: @user_test2 }
      else
        format.html { render :new }
        format.json { render json: @user_test2.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /user_test2s/1
  # PATCH/PUT /user_test2s/1.json
  def update
    respond_to do |format|
      if @user_test2.update(user_test2_params)
        format.html { redirect_to @user_test2, notice: 'User test2 was successfully updated.' }
        format.json { render :show, status: :ok, location: @user_test2 }
      else
        format.html { render :edit }
        format.json { render json: @user_test2.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_test2s/1
  # DELETE /user_test2s/1.json
  def destroy
    @user_test2.destroy
    respond_to do |format|
      format.html { redirect_to user_test2s_url, notice: 'User test2 was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_test2
      @user_test2 = UserTest2.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_test2_params
      params.require(:user_test2).permit(:username, :password)
    end
end
