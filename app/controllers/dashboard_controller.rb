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
    client = Client.find_by_user_id(current_user.id)

    if current_user.role == "client" && client.blank?
      @client = Client.new(params[:client])
      respond_to do |format|
        if @client.save
          format.html do
            if params[:commit] == "Send to Admin"
              UserMailer.client_info_mail_to_admin(@client).deliver!
            elsif params[:commit] == "Generate PDF"
              generate_pdf
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
        if @client.update_attributes(params[:client])
          format.html do
            if params[:commit] == "Send to Admin"
              UserMailer.client_info_mail_to_admin(@client).deliver!
            elsif params[:commit] == "Generate PDF"
              generate_pdf
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
      end
    end
  end

  def generate_pdf
    hss_partner = @client.hss_partner
    client_name = @client.client_name
    street_address_1 = @client.street_address1
    street_address_2 = @client.street_address2
    city = @client.city
    province = @client.province
    zip_code=@client.zip_code
    contact_name=@client.contact
    contact_phone = @client.contact_phone
    contact_email=@client.contact_email
    covered_entity=@client.covered_entity
    covered_entity_address1=@client.covered_entity_address1
    covered_entity_address2=@client.covered_entity_address2
    covered_entity_city=@client.covered_entity_city
    covered_entity_state=@client.covered_entity_state
    covered_entity_zip_code=@client.covered_entity_zip_code
    info_security_officer=@client.info_security_officer
    iso_title=@client.iso_title
    iso_telephone=@client.iso_telephone
    iso_email=@client.iso_email
    i_t_network_name=@client.i_t_network_name
    risk_assessment_report_date=@client.risk_assessment_report_date
    unique_project_identifier=@client.unique_project_identifier
    type_of_i_t_system=@client.type_of_i_t_system
    system_categorization= @client.system_categorization
    system_status= @client.system_status
    system_configuration= @client.system_configuration
    database = @client.database
    network_server_o_s = @client.network_server_o_s
    total_number_of_servers=@client.total_servers
    total_number_of_workstations = @client.total_workstations
    total_number_of_laptops = @client.total_laptops
    total_number_of_byods = @client.total_byods
    used_operating_systems=@client.in_use_operating_system
    use_email_or_not =@client.use_email_or_not
    used_products=@client.in_use_products
    in_house_email_server=@client.in_house_email_server
    firewall_model=@client.firewall_model
    firewall_serial_number=@client.firewall_serial_number
    firewall_warranty_status = @client.firewall_warranty_status
    firewall_inbound_outbound_rule_1 = @client.firewall_in_outbound_rule1
    firewall_inbound_outbound_rule_2 = @client.firewall_in_outbound_rule2
    firewall_inbound_outbound_rule_3 = @client.firewall_in_outbound_rule3
    v_p_n_s=@client.vpns
    emr_name=@client.emr_name
    emr_hosted_running=@client.emr_hosted_running
    isp_name=@client.isp_name
    isp_account_number = @client.isp_acc_no
    support_contract_number=@client.support_contract_no
    connection_type=@client.connection_type
    static_ip_information=@client.staic_ip_info
    network_ip=@client.network_ip
    network_subnet=@client.network_subnet
    network_gateway=@client.network_gateway
    network_dns_1=@client.network_dns1
    network_dns_2=@client.network_dns2
    clearing_house=@client.clearinghouse
    clearing_house_contact_number=@client.clearinghouse_contact_no
    clearing_house_interface_connection_type=@client.clearinghouse_interface_connection_type

    # client interfaces
    client_interface_arr = []
    client_interfaces_arr = []

    @client.client_interfaces.each do |client_interface|
      if client_interface.interface_name.present?
        client_interface_arr << client_interface.interface_name
      else
        client_interface_arr << "None"
      end
      if client_interface.contact_number.present?
        client_interface_arr << client_interface.contact_number
      else
        client_interface_arr << "None"
      end
      if client_interface.interface_connection_type.present?
        client_interface_arr << client_interface.interface_connection_type
      else
        client_interface_arr << "None"
      end
      client_interfaces_arr << client_interface_arr
      client_interface_arr = []
    end

    #    if @client.client_interfaces.blank?
    #      client_interface_arr << "None"
    #      client_interface_arr << "None"
    #      client_interface_arr << "None"
    #      client_interfaces_arr << client_interface_arr
    #    end


    # client contacts
    client_contact_arr = []
    client_contacts_arr = []

    @client.client_contacts.each do |client_contact |
      if client_contact.company.present?
        client_contact_arr << client_contact.company
      else
        client_contact_arr << "None"
      end
      if client_contact.name.present?
        client_contact_arr << client_contact.name
      else
        client_contact_arr << "None"
      end
      if client_contact.title.present?
        client_contact_arr << client_contact.title
      else
        client_contact_arr << "None"
      end
      if client_contact.phone.present?
        client_contact_arr << client_contact.phone
      else
        client_contact_arr << "None"
      end
      if client_contact.email.present?
        client_contact_arr << client_contact.email
      else
        client_contact_arr << "None"
      end
      if client_contact.participate_in.present?
        client_contact_arr << client_contact.participate_in
      else
        client_contact_arr << "None"
      end
      client_contacts_arr << client_contact_arr
      client_contact_arr = []
    end

    headers = []
    headers << "Contact Company"
    headers << "Contact Name"
    headers << "Contact Title"
    headers << "Contact Phone"
    headers << "Contact Email"
    headers << "Contact ParticipateIn"

    headers2 = []
    headers2 << "Interface Name"
    headers2 << "Interface Contact Number"
    headers2 << "interface_connection_type"

    pdf = Prawn::Document.generate("Client Information Sheet #{Date.today}.pdf",:page_layout => :landscape) do
      logopath =  "#{Rails.root}/app/assets/images/logo.png"
      image logopath, :width => 197, :height => 91,:style => :bold, :at => [35,560]

      move_down 80
      text "Client Information Sheet", :size => 16, :style => :bold, :align => :center

      move_down 30
      text "Client Information :", :size => 15, :style => :bold

      move_down 10
      text "HSS Partner : #{hss_partner}", :size => 13

      move_down 10
      text "Client Name : #{client_name}", :size => 13

      move_down 10
      text "Street Address : #{street_address_1}", :size => 13

      move_down 10
      text "Street Address 2 : #{street_address_2}", :size => 13


      move_down 10
      text "City : #{city}", :size => 13


      move_down 10
      text "Province : #{province}", :size => 13


      move_down 10
      text "Zip Code : #{zip_code}", :size => 13


      move_down 10
      text "Contact : #{contact_name}", :size => 13


      move_down 10
      text "Phone : #{contact_phone}", :size => 13


      move_down 10
      text "Email : #{contact_email}", :size => 13

      move_down 10
      text "Covered Entity : #{covered_entity}", :size => 13

      move_down 10
      text "Covered Entity Street Address : #{covered_entity_address1}", :size => 13

      move_down 10
      text "Covered Entity Street Address 2 : #{covered_entity_address2}", :size => 13

      move_down 10
      text "Covered Entity City : #{covered_entity_city}", :size => 13

      move_down 10
      text "Covered Entity State : #{covered_entity_state}", :size => 13

      move_down 10
      text "Covered Entity Zip Code : #{covered_entity_zip_code}", :size => 13

      move_down 10
      text "Information security officer : #{info_security_officer}", :size => 13

      move_down 10
      text "ISO Title : #{iso_title}", :size => 13

      move_down 10
      text "ISO Email : #{iso_email}", :size => 13

      move_down 10
      text "ISO Telephone : #{iso_telephone}", :size => 13

      move_down 10
      text "IT Network Name : #{i_t_network_name}", :size => 13

      move_down 10
      text "Risk assessment report date : #{risk_assessment_report_date}", :size => 13

      move_down 10
      text "Unique Project Identifier (UPI) : #{unique_project_identifier}", :size => 13

      move_down 10
      text "Type of IT system : #{type_of_i_t_system}", :size => 13

      move_down 10
      text "System categorization : #{system_categorization}", :size => 13


      move_down 10
      text "System status : #{system_status}", :size => 13


      move_down 10
      text "System configuration : #{system_configuration}", :size => 13


      move_down 10
      text "Database : #{database}", :size => 13


      move_down 10
      text "Network server OS : #{network_server_o_s}", :size => 13


      move_down 10
      text "How many Servers : #{total_number_of_servers}", :size => 13


      move_down 10
      text "How many Workstations : #{total_number_of_workstations}", :size => 13


      move_down 10
      text "How many laptops/tablets : #{total_number_of_laptops}", :size => 13


      move_down 10
      text "How many BYODs do you have : #{total_number_of_byods}", :size => 13


      move_down 10
      text "What operating systems are in use: #{used_operating_systems}", :size => 13

      move_down 10
      text "Email:", :size => 16, :style => :bold

      move_down 10
      text "Do you use Email? #{use_email_or_not}", :size => 13

      move_down 10
      text "What Product(s) do you use? #{used_products}", :size => 13

      move_down 10
      text "Do you have an in-house email server? #{in_house_email_server}", :size => 13

      move_down 10
      text "Firewall:", :size => 16, :style => :bold

      move_down 10
      text "Firewall Model : #{firewall_model}", :size => 13

      move_down 10
      text "Firewall S/N : #{firewall_serial_number}", :size => 13

      move_down 10
      text "Firewall warranty status : #{firewall_warranty_status}", :size => 13

      move_down 10
      text "Firewall inbound/outbound Rule 1 : #{firewall_inbound_outbound_rule_1}", :size => 13

      move_down 10
      text "Firewall inbound/outbound Rule 2 : #{firewall_inbound_outbound_rule_2}", :size => 13

      move_down 10
      text "Firewall inbound/outbound Rule 3 : #{firewall_inbound_outbound_rule_3}", :size => 13

      move_down 10
      text "Any VPN's (define) : #{v_p_n_s}", :size => 13

      move_down 10
      text "EMR:", :size => 16, :style => :bold

      move_down 10
      text "What is the name of EMR : #{emr_name}", :size => 13

      move_down 10
      text "Is the EMR hosted or running in-house : #{emr_hosted_running}", :size => 13

      move_down 25
      text "Information Contacts :", :size => 16, :style => :bold

      if client_contacts_arr.present?
        move_down 10
        table(client_contacts_arr, :cell_style => {:width => 95},:border_style => :grid,:row_colors => ["FFFFFF", "DDDDDD"],:column_widths => {0 => 75,1 =>80,2 =>80,3 =>94},:headers => true,:headers => headers) do
          cells.borders = [:bottom, :top, :left, :right]
        end
        move_down 10
      else
        move_down 10
        text "No client contacts found", :size => 13
      end
      
      move_down 10
      text "Internet connectivity :", :size => 16, :style => :bold

      move_down 10
      text "ISP Name : #{isp_name}", :size => 13


      move_down 10
      text "ISP account number : #{isp_account_number}", :size => 13


      move_down 10
      text "Support contract number : #{support_contract_number}", :size => 13


      move_down 10
      text "Connection type : #{connection_type}", :size => 13


      move_down 10
      text "Static IP info : #{static_ip_information}", :size => 13


      move_down 10
      text "Network IP : #{network_ip}", :size => 13


      move_down 10
      text "Network Subnet : #{network_subnet}", :size => 13


      move_down 10
      text "Network gateway : #{network_gateway}", :size => 13


      move_down 10
      text "Network DNS1 : #{network_dns_1}", :size => 13


      move_down 10
      text "Network DNS2 : #{network_dns_2}", :size => 13

      move_down 10
      text "Interfaces :", :size => 15, :style => :bold

      if client_interfaces_arr.present?
        move_down 10
        table(client_interfaces_arr, :cell_style => {:width => 95},:border_style => :grid,:row_colors => ["FFFFFF", "DDDDDD"],:column_widths => {0 => 95,1 =>150,2 =>150},:headers => true,:headers => headers2) do
          cells.borders = [:bottom, :top, :left, :right]
        end
        move_down 10
      else
        move_down 10
        text "No Interfaces found", :size => 13
      end
      
      move_down 10
      text "Clearinghouse :", :size => 15, :style => :bold

      move_down 10
      text "Clearing house : #{clearing_house}", :size => 13


      move_down 10
      text "contact number : #{clearing_house_contact_number}", :size => 13


      move_down 10
      text "Interface connection type : #{clearing_house_interface_connection_type}", :size => 13

      move_down 50
      text "This PDF Sheet is powered by Hipaa Security Suite", :size => 13, :align => :center
    end

    redirect_to dashboard_index_path(:pdf => pdf.path)
  end
end