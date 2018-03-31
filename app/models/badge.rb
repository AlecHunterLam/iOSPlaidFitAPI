class Badge < ApplicationRecord
    # Relationships
    has_many :earned_badges

    # Scopes
    scope :alphabetical,              -> { order(:badge_name) }

    # Validations
    validates_presence_of :badge_name, :requirements, :badge_description
    validates_uniqueness_of :badge_name, :requirements

end
