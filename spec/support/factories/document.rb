FactoryGirl.define do
  factory :document do
    document_file_name    'test.jpeg'
    document_content_type 'image/jpeg'
    document_file_size    45
  end
end
