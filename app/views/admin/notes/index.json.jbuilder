json.count @notes.count
json.page @notes.current_page
json.per_page @notes.per_page
json.pages_count @notes.total_pages
json.notes @notes do |note|
  json.id note.id
  json.note note.note
  json.animal do
    json.id note.animal.id
    json.bame note.animal.name
  end
  json.created_at note.created_at
  json.updated_at note.updated_at
end