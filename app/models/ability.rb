class Ability
  include CanCan::Ability
  def initialize(user)
    if user
      @user = user
      @user.roles.each { |role| send(role.name.downcase) }
    end
  end
  
  def standard
    
    can :manage, :twitter_account

    can :read, AdoptAnimal, animal: { organization: { id: @user.organization_id } }
    can :create, AdoptAnimal, animal: { organization: { id: @user.organization_id } }
    can :destroy, AdoptAnimal, animal: { organization: { id: @user.organization_id } }

    can :read, AdoptionContact, organization: { id: @user.organization_id }
    can :create, AdoptionContact
    can :update, AdoptionContact, organization: { id: @user.organization_id }

    can :read, Animal, organization: { id: @user.organization_id }
    can :create, Animal
    can :update, Animal, organization: { id: @user.organization_id }
    can :duplicate, Animal, organization: { id: @user.organization_id }
    can :qr_code, Animal, organization: { id: @user.organization_id }
    can :cage_card, Animal, organization: { id: @user.organization_id }
    can :add_image, Animal, organization: { id: @user.organization_id }

    can :read, AnimalColor, organization: { id: @user.organization_id }
    can :create, AnimalColor
    can :update, AnimalColor, organization: { id: @user.organization_id }

    can :read, AnimalWeight, organization: { id: @user.organization_id }
    can :create, AnimalWeight
    can :update, AnimalWeight, organization: { id: @user.organization_id }
    
    can :read, Note, animal: { organization: { id: @user.organization_id } }
    can :create, Note, animal: { organization: { id: @user.organization_id } }
    can :update, Note, animal: { organization: { id: @user.organization_id } }
    can :destroy, Note, animal: { organization: { id: @user.organization_id } }
    
    can :read, Document, documentable: { organization: { id: @user.organization_id } }
    can :create, Document, documentable: { organization: { id: @user.organization_id } }
    can :update, Document, documentable: { organization: { id: @user.organization_id } }
    can :destroy, Document, documentable: { organization: { id: @user.organization_id } }

    can :read, Organization, :id => @user.organization_id

    can :read, RelinquishAnimal, animal: { organization: { id: @user.organization_id } }
    can :create, RelinquishAnimal, animal: { organization: { id: @user.organization_id } }
    can :destroy, RelinquishAnimal, animal: { organization: { id: @user.organization_id } }

    can :read, RelinquishmentContact, organization: { id: @user.organization_id }
    can :create, RelinquishmentContact
    can :update, RelinquishmentContact, organization: { id: @user.organization_id }

    can :read, Shelter, organization: { id: @user.organization_id }
    can :create, Shelter
    can :update, Shelter, organization: { id: @user.organization_id }

    can :read, Species, organization: { id: @user.organization_id }
    can :create, Species
    can :update, Species, organization: { id: @user.organization_id }

    can :read, User, organization: { id: @user.organization_id }
    can :update, User, :id => @user.id

    can :read, VetContact, organization: { id: @user.organization_id }
    can :create, VetContact
    can :update, VetContact, organization: { id: @user.organization_id }

    can :read, VolunteerContact, organization: { id: @user.organization_id }
    can :create, VolunteerContact
    can :update, VolunteerContact, organization: { id: @user.organization_id }

    can :read, Status, organization: { id: @user.organization_id }
    can :create, Status
    can :update, Status, organization: { id: @user.organization_id }
    can :export, Status, organization: { id: @user.organization_id }

    can :read, Shot, organization: { id: @user.organization_id }
    can :create, Shot
    can :update, Shot, organization: { id: @user.organization_id }
    can :destroy, Shot, organization: { id: @user.organization_id }
    
    can :read, AnimalSex
    can :read, SpayNeuter
    can :read, Biter
  end

  def admin
    standard
    
    can :destroy, AdoptionContact, organization: { id: @user.organization_id }
    can :export, AdoptionContact, organization: { id: @user.organization_id }
    can :bulk_action, AdoptionContact, organization: { id: @user.organization_id }
    
    can :destroy, Animal, organization: { id: @user.organization_id }
    can :export, Animal, organization: { id: @user.organization_id }
    can :bulk_action, Animal, organization: { id: @user.organization_id }
    
    can :destroy, AnimalColor, organization: { id: @user.organization_id }
    can :export, AnimalColor, organization: { id: @user.organization_id }
    can :bulk_action, AnimalColor, organization: { id: @user.organization_id }

    can :destroy, AnimalWeight, organization: { id: @user.organization_id }
    can :export, AnimalWeight, organization: { id: @user.organization_id }
    can :bulk_action, AnimalWeight, organization: { id: @user.organization_id }

    can :update, Organization, :id => @user.organization_id
    can :export, Organization, :id => @user.organization_id

    can :destroy, RelinquishmentContact, organization: { id: @user.organization_id }
    can :export, RelinquishmentContact, organization: { id: @user.organization_id }
    can :bulk_action, RelinquishmentContact, organization: { id: @user.organization_id }

    can :destroy, Shelter, organization: { id: @user.organization_id }
    can :export, Shelter, organization: { id: @user.organization_id }
    can :bulk_action, Shelter, organization: { id: @user.organization_id }

    can :destroy, Species, organization: { id: @user.organization_id }
    can :export, Species, organization: { id: @user.organization_id }
    can :bulk_action, Species, organization: { id: @user.organization_id }

    can :create, User
    can :update, User, organization: { id: @user.organization_id }
    can :export, User, organization: { id: @user.organization_id }
    can :destroy, User, organization: { id: @user.organization_id }
    can :bulk_action, User, organization: { id: @user.organization_id }

    can :destroy, VetContact, organization: { id: @user.organization_id }
    can :export, VetContact, organization: { id: @user.organization_id }
    can :bulk_action, VetContact, organization: { id: @user.organization_id }

    can :destroy, VolunteerContact, organization: { id: @user.organization_id }
    can :export, VolunteerContact, organization: { id: @user.organization_id }
    can :bulk_action, VolunteerContact, organization: { id: @user.organization_id }
    
    can :destroy, Status, organization: { id: @user.organization_id }
    can :bulk_action, Status, organization: { id: @user.organization_id }
  end
  
  def super_admin
    can :manage, :all
  end
  
  def superadmin
    can :manage, :all
  end
  
end
