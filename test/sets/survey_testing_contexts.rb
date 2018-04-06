module Contexts
  module TeamAssignmentContexts

    def create_stuff
      # soccer team
      @msoccer = Team.new(sport: "Soccer", gender: "Men", season: "Fall", active: true)

      # players
      @alec = User.create(first_name: "Alec", last_name: "Lam", andrew_id: "ahlam", email: "ahlam@andrew.cmu.edu", major: "Information Systems", phone: "1111111111", role: "Player", active: true, year: "Junior")
      @greg = User.create(first_name: "Greg", last_name: "Bellwoar", andrew_id: "gbellwoa", email: "gbellwoa@andrew.cmu.edu", major: "Business", phone: "1111111111", role: "Player", active: true, year: "Junior")
      @zack = User.create(first_name: "Zack", last_name: "Masciopinto", andrew_id: "zpm", email: "zpm@andrew.cmu.edu", major: "Engineering", phone: "1111111111", role: "Player", active: true, year: "Junior")
      @sam = User.create(first_name: "Sam", last_name: "Fazel", andrew_id: "sfazelsa", email: "sfazelsa@andrew.cmu.edu", major: "Engineering", phone: "1111111111", role: "Player", active: true, year: "Junior")

      # team assignments
      @alecsoccer = TeamAssignment.create(team: @msoccer, user: @alec, active: true, date_added: Time.now)
      @gregsoccer = TeamAssignment.create(team: @msoccer, user: @greg, active: true, date_added: Time.now)
      @zacksoccer = TeamAssignment.create(team: @msoccer, user: @zack, active: true, date_added: Time.now)
      @samsoccer = TeamAssignment.create(team: @msoccer, user: @sam, active: true, date_added: Time.now)
    end


    def delete_stuff
      @alecsoccer.delete
      @gregsoccer.delete
      @zacksoccer.delete
      @samsoccer.delete

      @alec.delete
      @greg.delete
      @zack.delete
      @sam.delete

      @msoccer.delete
    end

  end
end
