class Ability
  include CanCan::Ability

  # def initialize(user)
  #   # Define abilities for the passed in user here. For example:
  #   #
  #   #   user ||= User.new # guest user (not logged in)
  #   #   if user.admin?
  #   #     can :manage, :all
  #   #   else
  #   #     can :read, :all
  #   #   end
  #   #
  #   # The first argument to `can` is the action you are giving the user permission to do.
  #   # If you pass :manage it will apply to every action. Other common actions here are
  #   # :read, :create, :update and :destroy.
  #   #
  #   # The second argument is the resource the user can perform the action on. If you pass
  #   # :all it will apply to every resource. Otherwise pass a Ruby class of the resource.
  #   #
  #   # The third argument is an optional hash of conditions to further filter the objects.
  #   # For example, here the user can only update published articles.
  #   #
  #   #   can :update, Article, :published => true
  #   #
  #   # See the wiki for details: https://github.com/ryanb/cancan/wiki/Defining-Abilities
  #   
  # end
  def initialize(user)
    #user ||= User.new # guest user
    if user
      if user.role? :super_admin
        can :access, :rails_admin 
        can :manage, :all
      elsif user.role? :admin
        can :access, :rails_admin
        #can :manage, :all
        #can :manage, AdoptionContact, :animal => { :organization_id => user.organization_ids }
        can :read, AdoptionContact, :animal => { :organization_id => user.organization_ids }
        can :create, AdoptionContact
        can :update, AdoptionContact, :animal => { :organization_id => user.organization_ids }
        can :destroy, AdoptionContact,, :animal => { :organization_id => user.organization_ids }
        #can :manage, AdoptionContact
        #can :manage, Animal, :organization => { :id => user.organization_ids }
        can :read, Animal, :organization => { :id => user.organization_ids }
        can :create, Animal
        can :update, Animal, :organization => { :id => user.organization_ids }
        can :destroy, Animal, :organization => { :id => user.organization_ids }
        #can :manage, AnimalColor, :organization => { :id => user.organization_ids }
        can :read, AnimalColor, :organization => { :id => user.organization_ids }
        can :create, AnimalColor
        can :update, AnimalColor, :organization => { :id => user.organization_ids }
        can :destroy, AnimalColor, :organization => { :id => user.organization_ids }
        #can :manage, AnimalWeight, :animal => { :organization_id => user.organization_ids }
        can :read, AnimalWeight, :animal => { :organization_id => user.organization_ids }
        can :create, AnimalWeight
        can :update, AnimalWeight, :animal => { :organization_id => user.organization_ids }
        can :destroy, AnimalWeight, :animal => { :organization_id => user.organization_ids }
        #
        can :read, Organization, :id => user.organization_ids
        can :create, Organization
        can :update, Organization, :id => user.organization_ids
        can :destroy, Organization, :id => user.organization_ids
        #can :manage, RelinquishmentContact, :animal => { :organization_id => user.organization_ids }
        can :read, RelinquishmentContact, :animal => { :organization_id => user.organization_ids }
        can :create, RelinquishmentContact
        can :update, RelinquishmentContact, :animal => { :organization_id => user.organization_ids }
        can :destroy, RelinquishmentContact, :animal => { :organization_id => user.organization_ids }
        #can :manage, Role, :organization => { :id => user.organization_ids }
        #can :manage, Shelter, :organization => { :id => user.organization_ids }
        can :read, Shelter, :organization => { :id => user.organization_ids }
        can :create, Shelter
        can :update, Shelter, :organization => { :id => user.organization_ids }
        can :destroy, Shelter, :organization => { :id => user.organization_ids }
        #can :manage, Species, :organization => { :id => user.organization_ids }
        can :read, Species, :organization => { :id => user.organization_ids }
        can :create, Species
        can :update, Species, :organization => { :id => user.organization_ids }
        can :destroy, Species, :organization => { :id => user.organization_ids }
        can :manage, User, :id => user.id
        #can :manage, VetContact, :organization => { :id => user.organization_ids }
        can :read, VetContact, :organization => { :id => user.organization_ids }
        can :create, VetContact
        can :update, VetContact, :organization => { :id => user.organization_ids }
        can :destroy, VetContact, :organization => { :id => user.organization_ids }
        #can :manage, VolunteerContact, :organization => { :id => user.organization_ids }
        can :read, VolunteerContact, :organization => { :id => user.organization_ids }
        can :create, VolunteerContact
        can :update, VolunteerContact, :organization => { :id => user.organization_ids }
        can :destroy, VolunteerContact, :organization => { :id => user.organization_ids }
      elsif user.role? :standard
        can :access, :rails_admin 
        #can :manage, :all
      end
    end
  end
end
