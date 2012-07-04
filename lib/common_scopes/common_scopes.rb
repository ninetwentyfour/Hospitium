module CommonScopes
  extend ActiveSupport::Concern

  def self.included(klass)
    klass.instance_eval do
      #scope for limiting to current user organization
      scope :organization, lambda{ |user| { :conditions => { :organization_id => user.organization_id } } }
    end
  end
end