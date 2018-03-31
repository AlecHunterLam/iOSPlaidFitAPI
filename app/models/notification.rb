class Notification < ApplicationRecord
  # Constants
  PRIORITIES = [['Low', :low], ['Medium', :medium], ['High', :high]]

  # Relations
  belongs_to :user

  # Scopes
  scope :for_receiver,     -> (user) { where(receiver_id: user) }
  scope :from_sender,      -> (user) { where(sender_id: user) }
  scope :for_priority,     -> (priority) { where(priority: priority) }
  scope :active,           -> { where(active: true) }
  scope :inactive,         -> { where(active: false)}
  scope :for_time_in_range,  (startTime, endTime) -> { where("notified_time BETWEEN startTime AND endTime") }
  scope :chronological,          -> { order(:notified_time)}

  # Validations
  validates_presence_of :sender_id, :receiver_id, :message, :active
  validates_timeliness_of :notified_time, on_or_before: Date.current
  validates_inclusion_of :type, in: PRIORITIES.map{|key, value| value}, message: "is not a valid priority setting"
  # Methods

end
