module Contexts
  module TeamAssignmentContexts

    def create_stuff
      # soccer team
      @m_soccer = Team.new(sport: "Soccer", gender: "Men", season: "Fall", active: true)

      # players
      @alec = User.create(first_name: "Alec", last_name: "Lam", andrew_id: "ahlam", email: "ahlam@andrew.cmu.edu", major: "Information Systems", phone: "1111111111", role: "Player", active: true, year: "Junior")
      @greg = User.create(first_name: "Greg", last_name: "Bellwoar", andrew_id: "gbellwoa", email: "gbellwoa@andrew.cmu.edu", major: "Business", phone: "1111111111", role: "Player", active: true, year: "Junior")
      @zack = User.create(first_name: "Zack", last_name: "Masciopinto", andrew_id: "zpm", email: "zpm@andrew.cmu.edu", major: "Engineering", phone: "1111111111", role: "Player", active: true, year: "Junior")
      @sam = User.create(first_name: "Sam", last_name: "Fazel", andrew_id: "sfazelsa", email: "sfazelsa@andrew.cmu.edu", major: "Engineering", phone: "1111111111", role: "Player", active: true, year: "Junior")

      # team assignments
      @alec_soccer = TeamAssignment.create(team: @m_soccer, user: @alec, active: true, date_added: Time.now)
      @greg_soccer = TeamAssignment.create(team: @m_soccer, user: @greg, active: true, date_added: Time.now)
      @zack_soccer = TeamAssignment.create(team: @m_soccer, user: @zack, active: true, date_added: Time.now)
      @sam_soccer = TeamAssignment.create(team: @m_soccer, user: @sam, active: true, date_added: Time.now)

      # Practices from today (April 6, 2018) back to March 30, 2018
      # with a double session on April 1st, 2018 ==> 8 day spread

      # 4/6/2018
      @practice_1_april_6 = Practice.create(team: @m_soccer, duration: 120, difficulty: 6, practice_time: Time.new(2018,4,6,8,30,0,'-04:00'))
      @practice_1_april_5 = Practice.create(team: @m_soccer, duration: 0, difficulty: 0, practice_time: Time.new(2018,4,5,11,0,0,'-04:00'))
      @practice_1_april_4 = Practice.create(team: @m_soccer, duration: 30, difficulty: 2, practice_time: Time.new(2018,4,4,13,0,0,'-04:00'))
      @practice_1_april_3 = Practice.create(team: @m_soccer, duration: 90, difficulty: 4, practice_time: Time.new(2018,4,3,12,0,0,'-04:00'))
      @practice_1_april_2 = Practice.create(team: @m_soccer, duration: 180, difficulty: 9, practice_time: Time.new(2018,4,2,19,0,0,'-04:00'))
      @practice_2_april_1 = Practice.create(team: @m_soccer, duration: 120, difficulty: 7, practice_time: Time.new(2018,4,1,16,0,0,'-04:00'))
      @practice_1_april_1 = Practice.create(team: @m_soccer, duration: 120, difficulty: 1, practice_time: Time.new(2018,4,1,6,0,0,'-04:00'))
      @practice_1_march_31 = Practice.create(team: @m_soccer, duration: 60, difficulty: 5, practice_time: Time.new(2018,3,31,16,30,0,'-04:00'))
      @practice_1_march_30 = Practice.create(team: @m_soccer, duration: 120, difficulty: 8, practice_time: Time.new(2018,3,30,16,0,0,'-04:00'))

      # Alec's post-practice surveys

      survey_post_april_1_march_30 = SurveyService.new({
                                      user_id: @alec.id,
                                      team_id: @m_soccer.id,
                                      practice_id: @practice_1_april_6.id,
                                      survey_type: 'Post-Practice',
                                      # for testing dates and stuff
                                      datetime_today: Time.new(2018,3,30,23,59,59,'-04:00'),
                                      player_rpe_rating: 5,
                                      player_personal_performance: 1,
                                      participated_in_full_practice: true,
                                      minutes_participated: nil
                                     })
      @survey_post_1_april_6 = survey_post_april_6_service.get_survey_object











      survey_post_april_6_service = SurveyService.new({
                                      user_id: @alec.id,
                                      team_id: @m_soccer.id,
                                      practice_id: @practice_1_april_6.id,
                                      survey_type: 'Post-Practice',
                                      # for testing dates and stuff
                                      datetime_today: Time.new(2018,4,6,23,59,59,'-04:00'),
                                      player_rpe_rating: 5,
                                      player_personal_performance: 1,
                                      participated_in_full_practice: true,
                                      minutes_participated: nil
                                     })
      @survey_post_april_6 = survey_post_april_6_service.get_survey_object

    end


    def delete_stuff
      @alec_soccer.delete
      @greg_soccer.delete
      @zack_soccer.delete
      @sam_soccer.delete

      @practice_1_april_6.delete
      @practice_1_april_5.delete
      @practice_1_april_4.delete
      @practice_1_april_3.delete
      @practice_1_april_2.delete
      @practice_2_april_1.delete
      @practice_1_april_1.delete
      @practice_1_march_31.delete
      @practice_1_march_30.delete

      @alec.delete
      @greg.delete
      @zack.delete
      @sam.delete

      @m_soccer.delete
    end

  end
end





# get_survey_object
