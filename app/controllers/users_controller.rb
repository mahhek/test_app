class UsersController < ApplicationController
  layout 'client'
  before_filter :authenticate_user!

  def index
    @users = User.where(:is_active => true)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  def new
    @user = User.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  def create
    @user = User.new(params[:user])
    password = params[:user][:password]
    
    respond_to do |format|
      if @user.save
        format.html do
          UserMailer.new_user_email(@user, password).deliver!
          redirect_to admin_user_path(@user.id)
          flash[:notice] = 'User was successfully created.'
        end
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find_by_id(params[:id])
    password = params[:user][:password]

    if params[:user][:password].present?
      @user_updated = @user.update_attributes(params[:user])
      UserMailer.edit_user_password(@user, password).deliver!
    else
      @user_updated = @user.update_without_password(params[:user])
    end
    respond_to do |format|
      if @user_updated
        format.html {redirect_to admin_user_path(@user), :notice => "User was successfully updated."}
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end
end
