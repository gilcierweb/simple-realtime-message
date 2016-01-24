json.array!(@messages) do |message|
  json.extract! message, :id, :name, :email, :subject, :message, :seen
  json.url message_url(message, format: :json)
end
