module Contexts
  module TeamContexts
    def create_teams
      @msoccer = Team.create(sport: “soccer”, gender: “Men”, season: "fall", active: true)
    end

    def delete_teams
      @msoccer.delete
    end
  end
end
