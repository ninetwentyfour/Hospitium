class Ability
  include CanCan::Ability
  def initialize(user)
    #user ||= User.new # guest user
    if user
      if user.role? :super_admin
        can :access, :rails_admin 
        can :manage, :all
      elsif user.role? :admin
        can :access, :rails_admin
        can :manage, :twitter_account
        #can :manage, :all
        #can :manage, AdoptionContact, :animal => { :organization_id => user.organization_ids }
        can :read, AdoptionContact, :organization => { :id => user.organization_id }
        can :create, AdoptionContact
        can :update, AdoptionContact, :organization => { :id => user.organization_id }
        can :destroy, AdoptionContact, :organization => { :id => user.organization_id }
        can :export, AdoptionContact, :organization => { :id => user.organization_id }
        can :bulk_action, AdoptionContact, :organization => { :id => user.organization_id }
        #can :manage, AdoptionContact
        #can :manage, Animal, :organization => { :id => user.organization_ids }
        can :read, Animal, :organization => { :id => user.organization_id }
        can :create, Animal
        can :update, Animal, :organization => { :id => user.organization_id }
        can :destroy, Animal, :organization => { :id => user.organization_id }
        can :export, Animal, :organization => { :id => user.organization_id }
        can :bulk_action, Animal, :organization => { :id => user.organization_id }
        #can :manage, AnimalColor, :organization => { :id => user.organization_ids }
        can :read, AnimalColor, :organization => { :id => user.organization_id }
        can :create, AnimalColor
        can :update, AnimalColor, :organization => { :id => user.organization_id }
        can :destroy, AnimalColor, :organization => { :id => user.organization_id }
        can :export, AnimalColor, :organization => { :id => user.organization_id }
        can :bulk_action, AnimalColor, :organization => { :id => user.organization_id }
        #can :manage, AnimalWeight, :animal => { :organization_id => user.organization_ids }
        can :read, AnimalWeight, :organization => { :id => user.organization_id }
        can :create, AnimalWeight
        can :update, AnimalWeight, :organization => { :id => user.organization_id }
        can :destroy, AnimalWeight, :organization => { :id => user.organization_id }
        can :export, AnimalWeight, :organization => { :id => user.organization_id }
        can :bulk_action, AnimalWeight, :organization => { :id => user.organization_id }
        #
        can :read, Organization, :id => user.organization_id
        #can :create, Organization
        can :update, Organization, :id => user.organization_id
        can :export, Organization, :id => user.organization_id
        #can :destroy, Organization, :id => user.organization_id
        #can :manage, RelinquishmentContact, :animal => { :organization_id => user.organization_ids }
        can :read, RelinquishmentContact, :organization => { :id => user.organization_id }
        can :create, RelinquishmentContact
        can :update, RelinquishmentContact, :organization => { :id => user.organization_id }
        can :destroy, RelinquishmentContact, :organization => { :id => user.organization_id }
        can :export, RelinquishmentContact, :organization => { :id => user.organization_id }
        can :bulk_action, RelinquishmentContact, :organization => { :id => user.organization_id }
        #can :manage, Role, :organization => { :id => user.organization_ids }
        #can :manage, Shelter, :organization => { :id => user.organization_ids }
        can :read, Shelter, :organization => { :id => user.organization_id }
        can :create, Shelter
        can :update, Shelter, :organization => { :id => user.organization_id }
        can :destroy, Shelter, :organization => { :id => user.organization_id }
        can :export, Shelter, :organization => { :id => user.organization_id }
        can :bulk_action, Shelter, :organization => { :id => user.organization_id }
        #can :manage, Species, :organization => { :id => user.organization_ids }
        can :read, Species, :organization => { :id => user.organization_id }
        can :create, Species
        can :update, Species, :organization => { :id => user.organization_id }
        can :destroy, Species, :organization => { :id => user.organization_id }
        can :export, Species, :organization => { :id => user.organization_id }
        can :bulk_action, Species, :organization => { :id => user.organization_id }
        #can :manage, User, :id => user.id
        can :read, User, :organization => { :id => user.organization_id }
        can :create, User
        can :update, User, :organization => { :id => user.organization_id }
        can :export, User, :organization => { :id => user.organization_id }
        can :bulk_action, User, :organization => { :id => user.organization_id }
        #can :manage, VetContact, :organization => { :id => user.organization_ids }
        can :read, VetContact, :organization => { :id => user.organization_id }
        can :create, VetContact
        can :update, VetContact, :organization => { :id => user.organization_id }
        can :destroy, VetContact, :organization => { :id => user.organization_id }
        can :export, VetContact, :organization => { :id => user.organization_id }
        can :bulk_action, VetContact, :organization => { :id => user.organization_id }
        #can :manage, VolunteerContact, :organization => { :id => user.organization_ids }
        can :read, VolunteerContact, :organization => { :id => user.organization_id }
        can :create, VolunteerContact
        can :update, VolunteerContact, :organization => { :id => user.organization_id }
        can :destroy, VolunteerContact, :organization => { :id => user.organization_id }
        can :export, VolunteerContact, :organization => { :id => user.organization_id }
        can :bulk_action, VolunteerContact, :organization => { :id => user.organization_id }
        #can :manage, VolunteerContact, :organization => { :id => user.organization_ids }
        can :read, Status, :organization => { :id => user.organization_id }
        can :create, Status
        can :update, Status, :organization => { :id => user.organization_id }
        can :destroy, Status, :organization => { :id => user.organization_id }
        can :export, Status, :organization => { :id => user.organization_id }
        can :bulk_action, Status, :organization => { :id => user.organization_id }
        
        can :read, AnimalSex
        can :read, SpayNeuter
        can :read, Biter
      elsif user.role? :standard
        can :access, :rails_admin
        can :manage, :twitter_account
        #can :manage, :all
        #can :manage, AdoptionContact, :animal => { :organization_id => user.organization_ids }
        can :read, AdoptionContact, :organization => { :id => user.organization_id }
        can :create, AdoptionContact
        can :update, AdoptionContact, :organization => { :id => user.organization_id }
        #can :manage, AdoptionContact
        #can :manage, Animal, :organization => { :id => user.organization_ids }
        can :read, Animal, :organization => { :id => user.organization_id }
        can :create, Animal
        can :update, Animal, :organization => { :id => user.organization_id }
        #can :manage, AnimalColor, :organization => { :id => user.organization_ids }
        can :read, AnimalColor, :organization => { :id => user.organization_id }
        can :create, AnimalColor
        can :update, AnimalColor, :organization => { :id => user.organization_id }
        #can :manage, AnimalWeight, :animal => { :organization_id => user.organization_ids }
        can :read, AnimalWeight, :organization => { :id => user.organization_id }
        can :create, AnimalWeight
        can :update, AnimalWeight, :organization => { :id => user.organization_id }
        #
        can :read, Organization, :id => user.organization_id
        #can :destroy, Organization, :id => user.organization_id
        #can :manage, RelinquishmentContact, :animal => { :organization_id => user.organization_ids }
        can :read, RelinquishmentContact, :organization => { :id => user.organization_id }
        can :create, RelinquishmentContact
        can :update, RelinquishmentContact, :organization => { :id => user.organization_id }
        #can :manage, Role, :organization => { :id => user.organization_ids }
        #can :manage, Shelter, :organization => { :id => user.organization_ids }
        can :read, Shelter, :organization => { :id => user.organization_id }
        can :create, Shelter
        can :update, Shelter, :organization => { :id => user.organization_id }
        #can :manage, Species, :organization => { :id => user.organization_ids }
        can :read, Species, :organization => { :id => user.organization_id }
        can :create, Species
        can :update, Species, :organization => { :id => user.organization_id }
        #can :manage, User, :id => user.id
        can :read, User, :organization => { :id => user.organization_id }
        can :update, User, :id => user.id
        #can :manage, VetContact, :organization => { :id => user.organization_ids }
        can :read, VetContact, :organization => { :id => user.organization_id }
        can :create, VetContact
        can :update, VetContact, :organization => { :id => user.organization_id }
        #can :manage, VolunteerContact, :organization => { :id => user.organization_ids }
        can :read, VolunteerContact, :organization => { :id => user.organization_id }
        can :create, VolunteerContact
        can :update, VolunteerContact, :organization => { :id => user.organization_id }
        #can :manage, VolunteerContact, :organization => { :id => user.organization_ids }
        can :read, Status, :organization => { :id => user.organization_id }
        can :create, Status
        can :update, Status, :organization => { :id => user.organization_id }
        can :export, Status, :organization => { :id => user.organization_id }
        
        can :read, AnimalSex
        can :read, SpayNeuter
        can :read, Biter
      end
    end
  end
end
