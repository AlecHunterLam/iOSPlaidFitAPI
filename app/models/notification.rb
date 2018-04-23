class Notification < ApplicationRecord
  # Constants
  PRIORITIES = [['Low', :low], ['Medium', :medium], ['High', :high]]

  # Relations
  belongs_to :user

  # Scopes
  scope :for_user_sent,     -> (user) { where(user_id: user) }
  scope :for_user_received,      -> (user) { where(receiver_id: user) }
  scope :for_priority,     -> (priority) { where(priority: priority) }
  scope :for_time_in_range, -> (startTime, endTime) { where("notified_time BETWEEN startTime AND endTime") }
  scope :chronological,          -> { order(notified_time: :DESC)}
  scope :reverse_chronological,          -> { order(notified_time: :ASC)}

  # Validations
  validates_presence_of :user_id, :receiver_id, :message, :priority
  validates_timeliness_of :notified_time, on_or_before: Date.tomorrow # time buffer
  validates_inclusion_of :priority, in: PRIORITIES.map{|key, value| key}, message: "is not a valid priority setting"
  validate :receiver_id_in_system

  # Methods
  private
  def receiver_id_in_system
    all_users = User.all.to_a
    all_users.map{ |user| user.id }
    all_users.select{ |user| user.id == self.receiver_id && user.id != self.user_id}
    if all_users == []
      return false
    else
      return true
    end
  end

end
