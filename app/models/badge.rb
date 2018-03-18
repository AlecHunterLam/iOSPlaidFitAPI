class Badge < ApplicationRecord

    # Relationships
    has_many :earned_badges

    # Scopes

    # Validations
    validates_presence_of :badge_name, :requirements

    # Methods

end
