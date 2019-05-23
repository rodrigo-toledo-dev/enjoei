json.array!(@messages) do |message|
  json.extract! message, :id, :title, :content, :state, :archived_at, :read_at
  json.url message_url(message, format: :json)
end
