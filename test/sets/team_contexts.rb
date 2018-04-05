module Contexts
  module TeamContexts
    def create_teams
      @team1 = @msoccer = Team.create(sport: “soccer”, gender: “Men”, season: "fall", active: true)
    end

    def delete_teams
      @team1.delete
    end
  end
end
