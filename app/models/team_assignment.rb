class TeamAssignment < ApplicationRecord

    # Relationships
    belongs_to :user
    belongs_to :team

    # Scopes
    scope :active,     -> { where(active: true) }
    scope :inactive,     -> { where(active: false) }

    # Validations
    validates_presence_of :team_id, :user_id, :active, :date_added

    # Methods
 
end
