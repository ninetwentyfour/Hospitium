module CommonScopes
  extend ActiveSupport::Concern

  def self.included(klass)
    klass.instance_eval do
      scope :organization, ->(user) { where(organization_id: user.organization_id) unless user.permissions.first.role_id == 1 }
    end
  end
end
