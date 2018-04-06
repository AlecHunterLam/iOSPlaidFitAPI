module Contexts
  module TeamContexts
    def create_teams
      @msoccer = Team.new(sport: "Soccer", gender: "Men", season: "Fall", active: true)
    end

    def delete_teams
      @msoccer.delete
    end
  end
end
