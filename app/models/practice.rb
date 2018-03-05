class Practice < ApplicationRecord

    # Relationships
    belongs_to :team

    # Scopes

    # Validations
    validates_presence_of :team_id, :duration, :difficulty, :date
    duration_array = [0] + (0..120).to_a
    difficulty_array = [0] + (1..10).to_a
    validates :duration, numericality: { only_integer: true }, inclusion: { in: duration_array }
    validates :difficulty, numericality: { only_integer: true }, inclusion: { in: difficulty_array }
    validates_date :date

    # Methods

end