json.count @animal_weights.count
json.page @animal_weights.current_page
json.per_page @animal_weights.per_page
json.pages_count @animal_weights.total_pages
json.animal_weights @animal_weights do |animal_weight|
  json.id animal_weight.id
  json.weight animal_weight.weight
  json.animal do
    json.id animal_weight.animal.id unless animal_weight.animal.blank?
    json.name animal_weight.animal.name unless animal_weight.animal.blank?
  end
  json.date_of_weight animal_weight.date_of_weight
  json.created_at animal_weight.created_at
  json.updated_at animal_weight.updated_at
end