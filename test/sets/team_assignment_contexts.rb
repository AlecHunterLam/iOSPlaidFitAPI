module Contexts
  module TeamAssignmentContexts

    def create_team_assignments
      @alecsoccer = team_assignment.create(team: @msoccer, user_id: @alec, active: true)
      @gregsoccer = team_assignment.create(team: @msoccer, user_id: @greg, active: true)
      @zacksoccer = team_assignment.create(team: @msoccer, user_id: @zack, active: true)
      @samsoccer = team_assignment.create(team: @msoccer, user_id: @sam, active: true)

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
