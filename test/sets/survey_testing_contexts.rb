module Contexts
  module SurveyTestingContexts

    def create_stuff
      # soccer team
      @m_soccer = Team.create(sport: "Soccer", gender: "Men", season: "Fall", active: true)

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

      # March 30, 2018
      survey_post_1_march_30_service  = SurveyService.new({
                                      user_id: @alec.id,
                                      team_id: @m_soccer.id,
                                      practice_id: @practice_1_march_30.id,
                                      survey_type: 'Post-Practice',
                                      # for testing dates and stuff
                                      datetime_today: Time.new(2018,3,30,23,59,59,'-04:00'),
                                      player_rpe_rating: 8,
                                      player_personal_performance: 8,
                                      participated_in_full_practice: true,
                                      minutes_participated: nil
                                     })
      @survey_post_1_march_30 = survey_post_1_march_30_service.get_survey_object

      # March 31, 2018
      survey_post_1_march_31_service = SurveyService.new({
                                      user_id: @alec.id,
                                      team_id: @m_soccer.id,
                                      practice_id: @practice_1_march_31.id,
                                      survey_type: 'Post-Practice',
                                      # for testing dates and stuff
                                      datetime_today: Time.new(2018,3,31,23,59,59,'-04:00'),
                                      player_rpe_rating: 6,
                                      player_personal_performance: 9,
                                      participated_in_full_practice: true,
                                      minutes_participated: nil
                                     })
      @survey_post_1_march_31 = survey_post_1_march_31_service.get_survey_object

      # April 1, 2018 SESSION 1
      survey_post_1_april_1_service  = SurveyService.new({
                                      user_id: @alec.id,
                                      team_id: @m_soccer.id,
                                      practice_id: @practice_1_april_1.id,
                                      survey_type: 'Post-Practice',
                                      # for testing dates and stuff
                                      datetime_today: Time.new(2018,4,1,23,59,59,'-04:00'),
                                      player_rpe_rating: 0,
                                      player_personal_performance: 4,
                                      participated_in_full_practice: true,
                                      minutes_participated: nil
                                     })
      @survey_post_1_april_1 = survey_post_1_april_1_service.get_survey_object

      # April 1, 2018 SESSION 2
      survey_post_2_april_1_service  = SurveyService.new({
                                      user_id: @alec.id,
                                      team_id: @m_soccer.id,
                                      practice_id: @practice_2_april_1.id,
                                      survey_type: 'Post-Practice',
                                      # for testing dates and stuff
                                      datetime_today: Time.new(2018,4,1,23,59,59,'-04:00'),
                                      player_rpe_rating: 5,
                                      player_personal_performance: 9,
                                      participated_in_full_practice: false,
                                      minutes_participated: 60
                                     })
      @survey_post_2_april_1 = survey_post_2_april_1_service.get_survey_object

      # April 2, 2018
      survey_post_1_april_2_service  = SurveyService.new({
                                      user_id: @alec.id,
                                      team_id: @m_soccer.id,
                                      practice_id: @practice_1_april_2.id,
                                      survey_type: 'Post-Practice',
                                      # for testing dates and stuff
                                      datetime_today: Time.new(2018,4,2,23,59,59,'-04:00'),
                                      player_rpe_rating: 5,
                                      player_personal_performance: 9,
                                      participated_in_full_practice: false,
                                      minutes_participated: 60
                                     })
      @survey_post_1_april_2 = survey_post_1_april_2_service.get_survey_object

      # April 3, 2018
      survey_post_1_april_3_service  = SurveyService.new({
                                      user_id: @alec.id,
                                      team_id: @m_soccer.id,
                                      practice_id: @practice_1_april_3.id,
                                      survey_type: 'Post-Practice',
                                      # for testing dates and stuff
                                      datetime_today: Time.new(2018,4,3,23,59,59,'-04:00'),
                                      player_rpe_rating: 3,
                                      player_personal_performance: 7,
                                      participated_in_full_practice: false,
                                      minutes_participated: 30
                                     })
      @survey_post_1_april_3 = survey_post_1_april_3_service.get_survey_object

      # April 4, 2018
      survey_post_1_april_4_service  = SurveyService.new({
                                      user_id: @alec.id,
                                      team_id: @m_soccer.id,
                                      practice_id: @practice_1_april_4.id,
                                      survey_type: 'Post-Practice',
                                      # for testing dates and stuff
                                      datetime_today: Time.new(2018,4,4,23,59,59,'-04:00'),
                                      player_rpe_rating: 3,
                                      player_personal_performance: 8,
                                      participated_in_full_practice: true,
                                      minutes_participated: nil
                                     })
      @survey_post_1_april_4 = survey_post_1_april_4_service.get_survey_object

      # April 5, 2018 OFF DAY
      survey_post_1_april_5_service  = SurveyService.new({
                                      user_id: @alec.id,
                                      team_id: @m_soccer.id,
                                      practice_id: @practice_1_april_5.id,
                                      survey_type: 'Post-Practice',
                                      # for testing dates and stuff
                                      datetime_today: Time.new(2018,4,5,23,59,59,'-04:00'),
                                      player_rpe_rating: 0,
                                      player_personal_performance: 0,
                                      participated_in_full_practice: true,
                                      minutes_participated: nil
                                     })
      @survey_post_1_april_5 = survey_post_1_april_5_service.get_survey_object

      # April 6, 2018
      survey_post_1_april_6_service = SurveyService.new({
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
      @survey_post_1_april_6 = survey_post_1_april_6_service.get_survey_object


      # Daily Wellness Surveys

      # March 30, 2018
      survey_dw_march_30_service = SurveyService.new({
                                      user_id: @alec.id,
                                      team_id: @m_soccer.id,
                                      survey_type: 'Daily Wellness',
                                      # for testing dates and stuff
                                      datetime_today: Time.new(2018,3,30,23,59,59,'-04:00'),

                                      hours_of_sleep: 2,
                                      quality_of_sleep: 3,
                                      academic_stress: 2,
                                      life_stress: 1,
                                      soreness: 3,
                                      ounces_of_water_consumed: 40,
                                      hydration_quality: false
                                     })
      @survey_dw_march_30 = survey_dw_march_30_service.get_survey_object

      # March 31, 2018
      survey_dw_march_31_service = SurveyService.new({
                                      user_id: @alec.id,
                                      team_id: @m_soccer.id,
                                      survey_type: 'Daily Wellness',
                                      # for testing dates and stuff
                                      datetime_today: Time.new(2018,3,31,23,59,59,'-04:00'),

                                      hours_of_sleep: 3,
                                      quality_of_sleep: 1,
                                      academic_stress: 4,
                                      life_stress: 2,
                                      soreness: 2,
                                      ounces_of_water_consumed: 50,
                                      hydration_quality: true
                                     })
      @survey_dw_march_31 = survey_dw_march_31_service.get_survey_object

      # April 1, 2018
      survey_dw_april_1_service = SurveyService.new({
                                      user_id: @alec.id,
                                      team_id: @m_soccer.id,
                                      survey_type: 'Daily Wellness',
                                      # for testing dates and stuff
                                      datetime_today: Time.new(2018,4,1,23,59,59,'-04:00'),

                                      hours_of_sleep: 1,
                                      quality_of_sleep: 2,
                                      academic_stress: 2,
                                      life_stress: 1,
                                      soreness: 1,
                                      ounces_of_water_consumed: 0,
                                      hydration_quality: false
                                     })
      @survey_dw_april_1 = survey_dw_april_1_service.get_survey_object

      # April 2, 2018
      survey_dw_april_2_service = SurveyService.new({
                                      user_id: @alec.id,
                                      team_id: @m_soccer.id,
                                      survey_type: 'Daily Wellness',
                                      # for testing dates and stuff
                                      datetime_today: Time.new(2018,4,2,23,59,59,'-04:00'),

                                      hours_of_sleep: 4,
                                      quality_of_sleep: 1,
                                      academic_stress: 1,
                                      life_stress: 1,
                                      soreness: 4,
                                      ounces_of_water_consumed: 20,
                                      hydration_quality: true
                                     })
      @survey_dw_april_2 = survey_dw_april_2_service.get_survey_object

      # April 3, 2018
      survey_dw_april_3_service = SurveyService.new({
                                      user_id: @alec.id,
                                      team_id: @m_soccer.id,
                                      survey_type: 'Daily Wellness',
                                      # for testing dates and stuff
                                      datetime_today: Time.new(2018,4,3,23,59,59,'-04:00'),

                                      hours_of_sleep: 1,
                                      quality_of_sleep: 1,
                                      academic_stress: 1,
                                      life_stress: 1,
                                      soreness: 1,
                                      ounces_of_water_consumed: 50,
                                      hydration_quality: false
                                     })
      @survey_dw_april_3 = survey_dw_april_3_service.get_survey_object

      # April 4, 2018
      survey_dw_april_4_service = SurveyService.new({
                                      user_id: @alec.id,
                                      team_id: @m_soccer.id,
                                      survey_type: 'Daily Wellness',
                                      # for testing dates and stuff
                                      datetime_today: Time.new(2018,4,4,23,59,59,'-04:00'),

                                      hours_of_sleep: 7,
                                      quality_of_sleep: 4,
                                      academic_stress: 3,
                                      life_stress: 4,
                                      soreness: 3,
                                      ounces_of_water_consumed: 90,
                                      hydration_quality: true
                                     })
      @survey_dw_april_4 = survey_dw_april_4_service.get_survey_object


      # April 5, 2018
      survey_dw_april_5_service = SurveyService.new({
                                      user_id: @alec.id,
                                      team_id: @m_soccer.id,
                                      survey_type: 'Daily Wellness',
                                      # for testing dates and stuff
                                      datetime_today: Time.new(2018,4,5,23,59,59,'-04:00'),

                                      hours_of_sleep: 6,
                                      quality_of_sleep: 2,
                                      academic_stress: 2,
                                      life_stress: 4,
                                      soreness: 2,
                                      ounces_of_water_consumed: 100,
                                      hydration_quality: true
                                     })
      @survey_dw_april_5 = survey_dw_april_5_service.get_survey_object

      # April 6, 2018
      survey_dw_april_6_service = SurveyService.new({
                                      user_id: @alec.id,
                                      team_id: @m_soccer.id,
                                      survey_type: 'Daily Wellness',
                                      # for testing dates and stuff
                                      datetime_today: Time.new(2018,4,6,23,59,59,'-04:00'),

                                      hours_of_sleep: 0,
                                      quality_of_sleep: 5,
                                      academic_stress: 1,
                                      life_stress: 1,
                                      soreness: 3,
                                      ounces_of_water_consumed: 12,
                                      hydration_quality: true
                                     })
      @survey_dw_april_6 = survey_dw_april_6_service.get_survey_object
    end


    def delete_stuff
      @survey_post_1_march_30.delete
      @survey_post_1_march_31.delete
      @survey_post_2_april_1.delete
      @survey_post_1_april_2.delete
      @survey_post_1_april_3.delete
      @survey_post_1_april_4.delete
      @survey_post_1_april_5.delete
      @survey_post_1_april_6.delete

      @survey_dw_march_30.delete
      @survey_dw_march_31.delete
      @survey_dw_april_1.delete
      @survey_dw_april_2.delete
      @survey_dw_april_3.delete
      @survey_dw_april_4.delete
      @survey_dw_april_5.delete
      @survey_dw_april_6.delete

      # @survey_post_1_march_30
      # @survey_post_1_march_31
      # @survey_post_2_april_1
      # @survey_post_1_april_2
      # @survey_post_1_april_3
      # @survey_post_1_april_4
      # @survey_post_1_april_5
      # @survey_post_1_april_6

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

# Survey.destroy_all
# TeamAssignment.destroy_all
# Practice.destroy_all
# User.destroy_all
# Team.destroy_all
#
#
# load './app/services/survey_service_v2.rb'

# get_survey_object
