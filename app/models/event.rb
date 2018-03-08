class Event < ApplicationRecord
  # Relationships
  belongs_to :user

  # Scopes
  scope :upcoming,      -> { where('? <= event_time', Time.now) }
  scope :past,          -> { where('event_time <= ?', Time.now) }

  # Validations
  validates_presence_of :user_id, :description, :event_time
  validates_timeliness_of :event_time, on_or_after: Time.now

  # Methods


end
