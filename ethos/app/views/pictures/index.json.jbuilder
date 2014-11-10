json.array!(@pictures) do |picture|
  json.extract! picture, :id, :album_id, :ideaboard_id, :capton, :description
  json.url picture_url(picture, format: :json)
end
