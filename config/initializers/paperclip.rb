# Paperclip::Attachment.interpolations[:animalname] = proc do |attachment, style|
#   attachment.instance.try(:name).downcase.underscore
# end

# Paperclip::Attachment.interpolations[:createdat] = proc do |attachment, style|
#   attachment.instance.try(:created_at).to_i.to_s
# end

# Paperclip::Attachment.interpolations[:orgname] = proc do |attachment, style|
#   attachment.instance.try(:organization).try(:name).downcase.underscore
# end

Paperclip.interpolates :animalname do |attachment, style|
  attachment.instance.try(:name).downcase.parameterize.underscore
end

Paperclip.interpolates :docname do |attachment, style|
  attachment.instance.try(:document_file_size).to_i.to_s
end

Paperclip.interpolates :docolduid do |attachment, style|
  attachment.instance.try(:uuid)
end

Paperclip.interpolates :createdat do |attachment, style|
  attachment.instance.try(:created_at).to_i.to_s
end

Paperclip.interpolates :orgname do |attachment, style|
  attachment.instance.try(:organization).try(:name).downcase.parameterize.underscore
end

Paperclip.interpolates :selfname do |attachment, style|
  attachment.instance.try(:name).downcase.parameterize.underscore
end