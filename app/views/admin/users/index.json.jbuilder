json.count @users.count
json.page @users.current_page
json.per_page @users.per_page
json.pages_count @users.total_pages
json.users @users do |user|
  json.id user.id
  json.username user.username
  json.email user.email
  json.created_at user.created_at
  json.updated_at user.updated_at
end