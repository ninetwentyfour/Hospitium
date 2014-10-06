json.count @documents.count
json.page @documents.current_page
json.per_page @documents.per_page
json.pages_count @documents.total_pages
json.documents @documents do |document|
  json.id document.id
  json.file_name document.document_file_name
  json.url document.document.url
  json.created_at document.created_at
  json.updated_at document.updated_at
end