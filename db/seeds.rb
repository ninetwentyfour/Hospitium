# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

role = Role.create(:name => "SuperAdmin")
Role.create(:name => "Admin")
Role.create(:name => "Standard")

user = User.new(:username => "admin", :password => "pleasechange", :password_confirmation => "pleasechange", 
                    :email => "admin@example.com", :organization_name => "example org", :no_send_email => true,
                    :skip_default_role => true)
user.skip_confirmation!
user.save!

permission = Permission.new()
permission.user_id, permission.role_id = user.id, role.id
permission.save!