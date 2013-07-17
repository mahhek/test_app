class DashboardController < ApplicationController
  before_filter :authenticate_user!

  layout 'client'

  #  require "prawn"

  def index
    client = Client.find_by_user_id(current_user.id)
    if current_user.role == "client" && client.blank?
      @client = Client.new
    elsif client.present?
      @client = client
      @client_updated = "true"
    end
    if params[:pdf].present?
      send_file params[:pdf],
        :content_type => "application/pdf",
        :filename => "Client Information Sheet #{Date.today}.pdf"
    end
  end

  def create_client
    if params[:from_users].present?
      if params[:commit] == "Generate PDF"
        client = Client.find_by_user_id(params[:user_id])
      end
    else
      client = Client.find_by_user_id(current_user.id)
    end
    
    if current_user.role == "client" && client.blank?
      @client = Client.new(params[:client])
      respond_to do |format|
        if @client.save
          format.html do
            # save client_id to the user table
            current_user.client_id = @client.id
            current_user.save

            if params[:commit] == "Send to Admin"
              UserMailer.client_info_mail_to_admin(@client).deliver!
            elsif params[:commit] == "Generate PDF"
              generate_pdf(@client)
            end
            if params[:commit] != "Generate PDF"
              redirect_to "/dashboard"
            end
            flash[:notice] = 'Client was successfully Craeted.'
          end
          format.json { render json: @client, status: :created, location: @client }
        else
          format.html { render action: "index" }
          format.json { render json: @client.errors, status: :unprocessable_entity }
        end
      end
    elsif client.present?
      @client = client
      respond_to do |format|
        if params[:client].present?
          if @client.update_attributes(params[:client])
            format.html do
              # save client_id to the user table
              current_user.client_id = @client.id
              current_user.save
            
              if params[:commit] == "Send to Admin"
                UserMailer.client_info_mail_to_admin(@client).deliver!
              elsif params[:commit] == "Generate PDF"
                generate_pdf(@client)
              end
              if params[:commit] != "Generate PDF"
                redirect_to "/dashboard"
              end
              flash[:notice] = 'Client was successfully Updated.'
            end
            format.json { render json: @client, status: :created, location: @client }
          else
            format.html { render action: "index" }
            format.json { render json: @client.errors, status: :unprocessable_entity }
          end
        else
          format.html do
            generate_pdf(@client)
          end
          format.json { render json: @client, status: :created, location: @client }
        end
      end
    end
  end
end