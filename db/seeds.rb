# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

#create the three standard roles
role = Role.create(:name => "SuperAdmin")
Role.create(:name => "Admin")
Role.create(:name => "Standard")

#create the first user in the system
user = User.new(:username => "admin", :password => "pleasechange", :password_confirmation => "pleasechange", 
                    :email => "admin@example.com", :organization_name => "example org", :no_send_email => true,
                    :skip_default_role => true)
user.skip_confirmation!
user.save!

#give that user permissions - will be super admin
permission = Permission.new()
permission.user_id, permission.role_id = user.id, role.id
permission.save!


#create other defaults for new install
AnimalSex.create(:sex => "Male")
AnimalSex.create(:sex => "Female")
AnimalSex.create(:sex => "Unknown")

Biter.create(:value => "No")
Biter.create(:value => "Yes")
Biter.create(:value => "Unknown")

SpayNeuter.create(:spay => "No")
SpayNeuter.create(:spay => "Yes")
SpayNeuter.create(:spay => "Unknown")