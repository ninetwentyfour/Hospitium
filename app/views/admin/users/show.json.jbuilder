json.id @user.id
json.username @user.username
json.email @user.email
if current_user.id == @user.id
  json.authentication_token @user.authentication_token
end
json.role @user.roles.first.name
json.created_at @user.created_at
json.updated_at @user.updated_at