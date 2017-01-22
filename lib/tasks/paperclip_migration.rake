namespace :paperclip_migration do
  desc 'Migrate data'
  task migrate_s3: :environment do
    # Make sure that all of the models have been loaded so any attachments are registered
    puts 'Loading models...'
    # Dir[Rails.root.join('app', 'models', 'animal.rb')].each { |file| File.basename(file, '.rb').camelize.constantize }

    # Iterate through all of the registered attachments
    puts 'Migrating attachments...'
    attachment_registry.each_definition do |klass, name, _options|
      next unless klass.to_s == 'Document'
      puts "Migrating #{klass}: #{name}"
      # klass.find_each(batch_size: 10) do |instance|
      #   attachment = instance.send(name)

      #   unless attachment.blank?
      #     attachment.styles.each do |style_name, style|
      #       old_path = interpolator.interpolate(old_path_option, attachment, style_name)
      #       new_path = interpolator.interpolate(new_path_option, attachment, style_name)
      #       puts "BUCKET: #{s3_bucket}, #{style_name}:\n\told: #{old_path}\n\tnew: #{new_path}"
      #       # s3_copy(s3_bucket, old_path, new_path)
      #     end
      #   end
      # end
      klass.find_each(batch_size: 100) do |instance|
        # klass.all.limit(500).each do |instance|
        attachment = instance.send(name)

        unless attachment.blank?
          if klass.to_s == 'Animal'
            # for animals and things with styles
            attachment.styles['original'] = 'original'
            attachment.styles.each do |style_name, _style|
              old_path = interpolator.interpolate(old_path_option, attachment, style_name)
              new_path = interpolator.interpolate(new_path_option, attachment, style_name)
              puts "BUCKET: #{s3_bucket}, #{style_name}:\n\told: #{old_path}\n\tnew: #{new_path}"
              # s3_copy(s3_bucket, old_path, new_path)
            end
          else
            # for things without styles
            old_path = interpolator.interpolate(get_old_path(klass.to_s), attachment, 'original')
            new_path = interpolator.interpolate(get_new_path(klass.to_s), attachment, 'original')
            puts "BUCKET: #{s3_bucket}:\n\told: #{old_path}\n\tnew: #{new_path}"
            s3_copy(s3_bucket, old_path, new_path)
          end
        end
      end
    end

    puts 'Completed migration.'
  end

  #############################################################################
  private

  # Paperclip Configuration
  def attachment_registry
    Paperclip::AttachmentRegistry
  end

  def s3_bucket
    # ENV['S3_BUCKET']
    # 'hospitium-static-development'
    # 'hospitium-static'
    'hospitium-static-migrations'
  end

  def destination_s3_bucket
    # ENV['S3_BUCKET']
    # 'hospitium-static-migrations'
    'hospitium-static-v2'
  end

  def old_path_option
    # ':class/:id_partition/:attachment/:hash.:extension'

    # the animal original path
    # ':class/:attachment/:id_partition/:style/:filename'
    # the animal first migratin path
    ':class_migration/:animalname_:orgname_:createdat/:style/:filename'
  end

  def new_path_option
    # the animal final path
    ':class/:hash/:style/:filename'
    # the animal first migration path
    # ':class_migration/:animalname_:orgname_:createdat/:style/:filename'
  end

  def get_old_path(type)
    case type
    when 'Organization'
      # organization original path
      # ':hash/:filename'
      # the org first migration path
      ':class_migration/:selfname_:createdat/:filename'
    when 'Document'
      # document original path
      # ':attachment/:hash.:extension'
      # the document first migration path
      ':class_migration/:docname_:docolduid_:createdat/:filename'
    end
  end

  def get_new_path(type)
    case type
    when 'Organization'
      # organization final path
      ':attachment/:hash/:filename'
      # the org first migration path
      # ':class_migration/:selfname_:createdat/:filename'
    when 'Document'
      # document final path
      ':attachment/:hash.:extension'
      # the document first migration path
      # ':class_migration/:docname_:docolduid_:createdat/:filename'
    end
  end

  def interpolator
    Paperclip::Interpolations
  end

  # S3
  def s3
    AWS::S3.new(access_key_id: ENV['S3_KEY'], secret_access_key: ENV['S3_SECRET'])
  end

  def s3_copy(bucket, source, destination)
    source_object = s3.buckets[bucket].objects[source]
    dest = s3.buckets[destination_s3_bucket].objects[destination]
    destination_object = source_object.copy_to(dest, metadata: source_object.metadata.to_h)
    destination_object.acl = source_object.acl
    puts "Copied #{source}"
  rescue Exception => e
    puts "*Unable to copy #{source} - #{e.message}"
  end
end
