json.count @presenter.shots.count
json.page @presenter.shots.current_page
json.per_page @presenter.shots.per_page
json.pages_count @presenter.shots.total_pages
json.shots @presenter.shots do |shot|
  json.id shot.id
  json.name shot.name
  json.last_administered shot.last_administered
  json.expires shot.expires
  json.animal do
    json.id shot.animal.id
    json.name shot.animal.name
  end
  json.created_at shot.created_at
  json.updated_at shot.updated_at
end