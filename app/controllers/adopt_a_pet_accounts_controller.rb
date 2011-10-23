class AdoptAPetAccountsController < ApplicationController

  def create
    @adopt_a_pet_account = AdoptAPetAccount.new(params[:adopt_a_pet_account])
    @adopt_a_pet_account.user_id = current_user.id
    @adopt_a_pet_account.active = true
    @adopt_a_pet_account.organization_id = current_user.organization.id
    @adopt_a_pet_account.password = Base64.encode64("#{@adopt_a_pet_account.password}~#{current_user.username}")
    respond_to do |format|
      if  @adopt_a_pet_account.save
        format.html {redirect_to("#{root_url}admin/user/#{current_user.id}", :notice => 'Adopt A Pet Account Connected!')}
      else
        format.html { render :action => "new" }
      end
    end
  end
  
  
  def send_animal
    @account = AdoptAPetAccount.find_by_user_id(current_user.id)
    #@account.password = Base64.decode64(@account.password).split("~").first
    if @account.blank?
      redirect_to("#{root_url}admin/user/#{current_user.id}", :notice => 'Please Add Adopt A Pet Credentials!')
    else
      #get all animals for an organization
      @animals = Animal.find(:all, :conditions => {:organization_id => current_user.organization.id, :public => 1}) 
      csv_string = CSV.open("#{RAILS_ROOT}/tmp/#{current_user.id}_adopt_a_pet_export_temp.csv", "w") do |csv| 
        # header row 
        csv << ["ID", "Type", "Breed", "Breed2", "Name", "Sex", "Description", "Status", "SpayedNeutered", "PhotoURL", "PhotoURL2", "PhotoURL3"] 

        # data rows 
        @animals.each do |animal|
          csv << [animal.uuid, animal.species.name, animal.species.name, "", animal.name, animal.animal_sex.sex, animal.special_needs, "Available", animal.spay_neuter.spay,  animal.image.url(:medium),  animal.second_image.url(:medium),  animal.third_image.url(:medium)] 
        end 
      end 
      #read the newly created csv
      read_csv = CSV.new("#{RAILS_ROOT}/tmp/#{current_user.id}_adopt_a_pet_export_temp.csv")
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
    ftp.putbinaryfile("#{RAILS_ROOT}/public/adopt_a_pet/import.cfg", "import.cfg")
    ftp.quit()
    
    #delete the tmp file
    File.delete("#{RAILS_ROOT}/tmp/#{current_user.id}_adopt_a_pet_export_temp.csv")
  end

end

