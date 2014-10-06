json.id @presenter.shot.id
json.name @presenter.shot.name
json.last_administered @presenter.shot.last_administered
json.expires @presenter.shot.expires
json.animal do
  json.id @presenter.shot.animal.id
  json.name @presenter.shot.animal.name
end
json.created_at @presenter.shot.created_at
json.updated_at @presenter.shot.updated_at