class Rostered < ApplicationRecord

    # Relationships
    belongs_to :user
    belongs_to :team

    # Scopes

    # Validations
    validates_presence_of :team_id, :user_id

    # Methods

end
