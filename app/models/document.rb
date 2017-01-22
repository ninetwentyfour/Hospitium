class Document < ActiveRecord::Base
  include CommonScopes
  belongs_to :organization
  belongs_to :documentable, polymorphic: true

  attr_accessible :document, :animal_id, :documentable_type, :documentable_id, :organization_id

  has_attached_file :document,
                    storage: :s3,
                    s3_protocol: 'https',
                    s3_headers: { 'Expires' => 1.year.from_now.httpdate, 'Cache-Control' => 'max-age=2592000, no-transform, public' },
                    s3_credentials: { access_key_id: ENV['S3_KEY'], secret_access_key: ENV['S3_SECRET'] },
                    bucket: 'hospitium-static-v2',
                    url: '/system/:attachment/:hash.:extension',
                    hash_secret: ENV['SALTY']

  attr_accessor :filearrays

  # validates_presence_of :document_file_name, :document_content_type
  validates_attachment_presence :document
  validates_attachment_size :document, less_than: 100.megabytes
  do_not_validate_attachment_file_type :document
  validate :not_blacklisted_file

  def not_blacklisted_file
    forbiden_types = %w(ade adp bat chm cmd com cpl dll exe hta ins isp jse lib mde msc msp mst pif scr sct shb sys vb vbe vbs vxd wsc wsf wsh css javascript)

    extension = document_content_type.split('/').last

    errors.add(:document, 'FORBIDEN FILE EXTENSION: ' + extension) if forbiden_types.include?(extension)
  end
end
