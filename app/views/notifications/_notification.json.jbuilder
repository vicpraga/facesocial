json.extract! notification, :id, :sender_id, :receiver_id, :type, :message_id, :created_at, :updated_at
json.url notification_url(notification, format: :json)
