if Rails.env.test?

else
  AssetSync.configure do |config|
    config.fog_provider = 'AWS'
    config.aws_access_key_id = ENV['S3_KEY']
    config.aws_secret_access_key = ENV['S3_SECRET']
    config.fog_directory = ENV['FOG_DIRECTORY']

    # config.aws_access_key_id = "AKIAJCZTCSIU55PGYHSA"
    # config.aws_secret_access_key = "x92SrrbPSg8mwQFZ6BL9TadonYrdr6GhGxTf+zXS"
    # config.fog_directory = "hospitium-app-test"

    # Increase upload performance by configuring your region
    # config.fog_region = 'eu-west-1'
    #
    # Don't delete files from the store
    # config.existing_remote_files = "keep"
    #
    # Automatically replace files with their equivalent gzip compressed version
    config.gzip_compression = true
    #
    # Use the Rails generated 'manifest.yml' file to produce the list of files to
    # upload instead of searching the assets directory.
    # config.manifest = true
    #
    # Fail silently.  Useful for environments such as Heroku
    config.fail_silently = true
  end
end
