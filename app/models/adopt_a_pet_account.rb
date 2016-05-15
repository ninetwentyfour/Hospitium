class AdoptAPetAccount < ActiveRecord::Base
  belongs_to :user
  belongs_to :organization

  attr_accessible :user_name, :password

  def self.new_by_user(params, current_user)
    adopt_a_pet_account = self.new(params)
    adopt_a_pet_account.user_id = current_user.id
    adopt_a_pet_account.active = true
    adopt_a_pet_account.organization_id = current_user.organization_id
    adopt_a_pet_account.password = SecPass::encrypt(adopt_a_pet_account.password)
    adopt_a_pet_account
  end

  def send_csv(current_user)
    require 'csv'
    #get all animals for an organization
    @animals = Animal.organization(current_user).where(public: 1)
    csv_string = CSV.open("#{Rails.root}/tmp/#{current_user.id}_adopt_a_pet_export_temp.csv", 'w') do |csv|
      # header row
      csv << [
        'ID',
        'Type',
        'Breed',
        'Breed2',
        'Name',
        'Sex',
        'Description',
        'Status',
        'SpayedNeutered',
        'PhotoURL'
        ]

      # data rows
      @animals.each do |animal|
        csv << [
                  animal.id,
                  animal.species_name,
                  animal.species_name,
                  '',
                  animal.name,
                  animal.sex,
                  animal.special_needs,
                  'Available',
                  animal.spay,
                  animal.image.url(:large).sub(/https:/, "http:")
               ]
      end
    end

    #read the newly created csv
    read_csv = CSV.new("#{Rails.root}/tmp/#{current_user.id}_adopt_a_pet_export_temp.csv")
    # ftp it to adopt a pet
    self.ftp_csv(read_csv, current_user)
    true
  end

  def ftp_csv(file, current_user)
    @account = AdoptAPetAccount.find_by_user_id(user.id)
    @account.password = SecPass::decrypt(@account.password)
    #ftp it to adopt a pet account
    require 'net/ftp'
    ftp = Net::FTP.new('autoupload.adoptapet.com')
    ftp.passive = true
    ftp.login(user = @account.user_name, passwd = (@account.password+"wrong"))
    ftp.putbinaryfile(file.string(), 'pets.csv')
    ftp.putbinaryfile("#{Rails.root}/public/adopt_a_pet/import.cfg", 'import.cfg')
    ftp.quit()

    #delete the tmp file
    File.delete("#{Rails.root}/tmp/#{current_user.id}_adopt_a_pet_export_temp.csv")
  end
end
