class AdoptAPetAccountsController < ApplicationController
  
  respond_to :html, :xml, :json

  def create
    @adopt_a_pet_account = AdoptAPetAccount.new_by_user(params[:adopt_a_pet_account], current_user)
    if @adopt_a_pet_account.save
      flash[:notice] = 'Adopt A Pet Account Connected!'
    else
      flash[:error] = 'Adopt A Pet Account Was Not Connected!'
    end
    
    redirect_to "#{root_url}admin/users/#{current_user.id}"
  end
  
  def update
    @adopt_a_pet = AdoptAPetAccount.find(params[:id])
    params[:adopt_a_pet_account]["password"] = Base64.encode64("#{params[:adopt_a_pet_account]["password"]}~#{current_user.username}")
    respond_to do |format|
      if  @adopt_a_pet.update_attributes(params[:adopt_a_pet_account])
        format.html {redirect_to("#{root_url}admin/users/#{current_user.id}", :notice => 'Adopt A Pet Account updated!')}
      else
        format.html { render :action => "new" }
      end
    end
  end
  
  
  def send_animal
    require 'csv'
    
    @account = AdoptAPetAccount.find_by_user_id(current_user.id)
    #@account.password = Base64.decode64(@account.password).split("~").first
    if @account.blank?
      redirect_to("#{root_url}admin/users/#{current_user.id}", :notice => 'Please Add Adopt A Pet Credentials!')
    else
      #get all animals for an organization
      @animals = Animal.find(:all, :conditions => {:organization_id => current_user.organization.id, :public => 1}) 
      csv_string = CSV.open("#{Rails.root}/tmp/#{current_user.id}_adopt_a_pet_export_temp.csv", "w") do |csv| 
        # header row 
        csv << ["ID", "Type", "Breed", "Breed2", "Name", "Sex", "Description", "Status", "SpayedNeutered", "PhotoURL"] 

        # data rows 
        @animals.each do |animal|
          csv << [animal.uuid, animal.species_name, animal.species_name, "", animal.name, animal.sex, animal.special_needs, "Available", animal.spay,  animal.image.url(:large).sub(/https:/, "http:")] 
        end 
      end 
      
      #read the newly created csv
      read_csv = CSV.new("#{Rails.root}/tmp/#{current_user.id}_adopt_a_pet_export_temp.csv")
      send_to_them = ftp_csv(read_csv)
      redirect_to("#{root_url}admin/animals", :notice => 'Animals Sent To Adopt A Pet!')
    end
  end
  
  def ftp_csv(file)
    @account = AdoptAPetAccount.find_by_user_id(current_user.id)
    @account.password = Base64.decode64(@account.password).split("~").first
    logger.debug "The object is #{@account.password}"
    #ftp it to adopt a pet account
    require 'net/ftp'
    ftp = Net::FTP.new('autoupload.adoptapet.com')
    ftp.passive = true
    ftp.login(user = "#{@account.user_name}", passwd = "#{@account.password}")
    ftp.putbinaryfile(file.string(), "pets.csv")
    ftp.putbinaryfile("#{Rails.root}/public/adopt_a_pet/import.cfg", "import.cfg")
    ftp.quit()
    
    #delete the tmp file
    File.delete("#{Rails.root}/tmp/#{current_user.id}_adopt_a_pet_export_temp.csv")
  end
  
  def destroy
    @account = AdoptAPetAccount.find(params[:id])
    @account.destroy

    respond_to do |format|
      format.html {redirect_to("#{root_url}admin/users/#{current_user.id}", :notice => 'Adopt A Pet Account Deleted!')}
      format.xml  { head :ok }
    end
  end

end

