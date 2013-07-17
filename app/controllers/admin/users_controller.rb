class Admin::UsersController < ApplicationController
  layout 'admin'
  before_filter :authenticate_user!

  def index
    #    @users = User.where(:is_active => true)
    @users = []
    User.all.each do |user|
      if current_user.present? && current_user.id != user.id
        @users << user
      end
    end

    @users = @users.paginate(:page => params[:page], :per_page => 20)
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
      format.html {redirect_to admin_users_path, :notice => "User was successfully deleted."}
      format.json { head :no_content }
    end
  end

  def status
    @user = User.find_by_id(params[:user_id])
    if params[:status].to_s == "true"
      @user.is_active = 1
      @user.save!
    elsif params[:status].to_s == "false"
      @user.is_active = 0
      @user.save!
    end
    
    redirect_to admin_users_path
  end

  def generate_users_pdf
    if params[:users].present?
      user_arr = []
      users_arr = []
      #      users << params[:users]

      User.all.each do |user|
        if current_user.present? && current_user.id != user.id
          if user.fname.present?
            user_arr << user.fname
          else
            user_arr << "None"
          end
          if user.email.present?
            user_arr << user.email
          else
            user_arr << "None"
          end
          if user.company.present?
            user_arr << user.company
          else
            user_arr << "None"
          end
          if user.is_active == true
            user_arr << "active"
          else
            user_arr << "inactive"
          end
          users_arr << user_arr
          user_arr = []
        end
      end

      headers = []
      headers << "Name"
      headers << "Email"
      headers << "Company"
      headers << "Status"
    end
    if users_arr.present?
      pdf = Prawn::Document.generate("Listing Users #{Date.today}.pdf",:page_layout => :landscape) do
        move_down 10
        text "Listing Users", :size => 15, :style => :bold
        move_down 20
        table(users_arr, :cell_style => {:width => 95},:border_style => :grid,:row_colors => ["FFFFFF", "DDDDDD"],:column_widths => {0 => 120,1 =>90,2 =>80,3 =>90},:headers => true,:headers => headers) do
          cells.borders = [:bottom, :top, :left, :right]
        end
        move_down 10
      end
      
      send_file pdf.path,
        :content_type => "application/pdf",
        :filename => "Listing Users #{Date.today}.pdf"
    else
      pdf = Prawn::Document.generate("Listing Users #{Date.today}.pdf",:page_layout => :landscape) do
        move_down 10
        text "No user found.", :size => 10
      end
      send_file pdf.path,
        :content_type => "application/pdf",
        :filename => "Listing Users #{Date.today}.pdf"
    end
  end
end
