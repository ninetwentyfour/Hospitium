# Activity model for customisation & custom methods
class Activity < PublicActivity::Activity
  serialize :parameters, Hash
  alias_attribute :organization_id, :recipient_id
end
