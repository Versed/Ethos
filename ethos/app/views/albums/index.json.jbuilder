json.array!(@albums) do |album|
  json.extract! album, :id, :ideaboard_id, :title
  json.url album_url(album, format: :json)
end
