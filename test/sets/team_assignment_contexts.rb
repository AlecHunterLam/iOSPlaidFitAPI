module Contexts
  module TeamAssignmentContexts
    def create_team_assignments
      @ta1 = team_assignment.create(team_id: "1", user_id: "1", active: true)
      @ta2 = team_assignment.create(team_id: "2", user_id: "11", active: true)
      @ta3 = team_assignment.create(team_id: "3", user_id: "5", active: false)
      @ta4 = team_assignment.create(team_id: "4", user_id: "2", active: true)
      @ta5 = team_assignment.create(team_id: "5", user_id: "7", active: false)
      @ta6 = team_assignment.create(team_id: "6", user_id: "3", active: true)
    end

    def delete_team_assignments
      @ta1.delete
      @ta2.delete
      @ta3.delete
      @ta4.delete
      @ta5.delete
      @ta6.delete
    end
  end
end
