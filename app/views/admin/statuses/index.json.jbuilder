json.count @statuses.count
json.page @statuses.current_page
json.per_page @statuses.per_page
json.pages_count @statuses.total_pages
json.statuses @statuses do |status|
  json.id status.id
  json.status status.status
  json.created_at status.created_at
  json.updated_at status.updated_at
end