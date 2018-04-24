module Contexts
    module SurveyTestingContexts
# load './app/services/survey_service_v2.rb'
# require './test/sets/survey_testing_contexts'
# include Contexts::SurveyTestingContexts
# create_stuff
      def create_stuff
        # soccer team
        @m_soccer = Team.create(sport: "Soccer", gender: "Men", season: "Fall", active: true)
        # swim team
        @w_swim = Team.create(sport: "Swimming & Diving", gender: "Women", season: "Winter", active: true)
        @m_swim = Team.create(sport: "Swimming & Diving", gender: "Men", season: "Winter", active: true)
  
        # players
        @alec = User.create(first_name: "Alec", last_name: "Lam", andrew_id: "ahlam", email: "ahlam@andrew.cmu.edu", major: "Information Systems", phone: "1111111111", role: "Player", active: true, year: "Junior", password: 'secret', password_confirmation: 'secret')
        @greg = User.create(first_name: "Greg", last_name: "Bellwoar", andrew_id: "gbellwoa", email: "gbellwoa@andrew.cmu.edu", major: "Business", phone: "1111111111", role: "Player", active: true, year: "Junior", password: 'secret', password_confirmation: 'secret')
        @zack = User.create(first_name: "Zack", last_name: "Masciopinto", andrew_id: "zpm", email: "zpm@andrew.cmu.edu", major: "Engineering", phone: "1111111111", role: "Player", active: true, year: "Junior", password: 'secret', password_confirmation: 'secret')
        @sam = User.create(first_name: "Sam", last_name: "Fazel", andrew_id: "sfazelsa", email: "sfazelsa@andrew.cmu.edu", major: "Engineering", phone: "1111111111", role: "Player", active: true, year: "Junior", password: 'secret', password_confirmation: 'secret')
        @coach = User.create(first_name: "Matt", last_name: "Kinney", andrew_id: "mkinney", email: "mkinney@andrew.cmu.edu", major: "Other", phone: "1111111111", role: "Coach", active: true, year: "Other", password: 'secret', password_confirmation: 'secret')
        @soccer_coach = User.create(first_name: "Bob", last_name: "Smith", andrew_id: "bsmith", email: "bsmith@andrew.cmu.edu", major: "Other", phone: "1111111111", role: "Coach", active: true, year: "Other", password: 'secret', password_confirmation: 'secret')
        @llie = User.create(first_name: "Allie", last_name: "Caron", andrew_id: "acaron", email: "acaron@andrew.cmu.edu", major: "Engineering", phone: "5189374228", role: "Player", active: true, year: "Junior", password: 'secret', password_confirmation: 'secret')
        @trainer = User.create(first_name: "Adam", last_name: "May", andrew_id: "amay", email: "amay@andrew.cmu.edu", major: "Other", phone: "5189374228", role: "Athletic Trainer", active: true, year: "Other", password: 'secret', password_confirmation: 'secret')
  
        # team assignments
        @alec_soccer = TeamAssignment.create(team: @m_soccer, user: @alec, active: true, date_added: Time.now)
        @greg_soccer = TeamAssignment.create(team: @m_soccer, user: @greg, active: true, date_added: Time.now)
        @zack_soccer = TeamAssignment.create(team: @m_soccer, user: @zack, active: true, date_added: Time.now)
        @sam_soccer = TeamAssignment.create(team: @m_soccer, user: @sam, active: true, date_added: Time.now)
        @coach_swim = TeamAssignment.create(team: @m_swim, user: @coach, active: true, date_added: Time.now)
        @coach_swim2 = TeamAssignment.create(team: @w_swim, user: @coach, active: true, date_added: Time.now)
        @coach_soccer = TeamAssignment.create(team: @m_soccer, user: @soccer_coach, active: true, date_added: Time.now)
        @llie_swim = TeamAssignment.create(team: @w_swim, user: @llie, active: true, date_added: Time.now)
  
        # Practices from today (April 6, 2018) back to March 30, 2018
        # with a double session on April 1st, 2018 ==> 8 day spread
  
        # 4/6/2018
        @practice_1_april_6 = Practice.create(team: @m_soccer, duration: 120, difficulty: 6, practice_time: Time.new(2018,4,23,8,30,0,'-04:00'))
        @practice_1_april_5 = Practice.create(team: @m_soccer, duration: 0, difficulty: 0, practice_time: Time.new(2018,4,22,11,0,0,'-04:00'))
        @practice_1_april_4 = Practice.create(team: @m_soccer, duration: 30, difficulty: 2, practice_time: Time.new(2018,4,21,13,0,0,'-04:00'))
        @practice_1_april_3 = Practice.create(team: @m_soccer, duration: 90, difficulty: 4, practice_time: Time.new(2018,4,20,12,0,0,'-04:00'))
        @practice_1_april_2 = Practice.create(team: @m_soccer, duration: 180, difficulty: 9, practice_time: Time.new(2018,4,19,19,0,0,'-04:00'))
        @practice_2_april_1 = Practice.create(team: @m_soccer, duration: 120, difficulty: 7, practice_time: Time.new(2018,4,18,16,0,0,'-04:00'))
        @practice_1_april_1 = Practice.create(team: @m_soccer, duration: 120, difficulty: 1, practice_time: Time.new(2018,4,17,6,0,0,'-04:00'))
        @practice_1_march_31 = Practice.create(team: @m_soccer, duration: 60, difficulty: 5, practice_time: Time.new(2018,4,16,16,30,0,'-04:00'))
        @practice_1_march_30 = Practice.create(team: @m_soccer, duration: 120, difficulty: 8, practice_time: Time.new(2018,4,15,16,0,0,'-04:00'))
        @swim_practice_1_april_6 = Practice.create(team: @w_swim, duration: 120, difficulty: 6, practice_time: Time.new(2018,4,23,8,30,0,'-04:00'))
        @swim_practice_1_april_5 = Practice.create(team: @w_swim, duration: 0, difficulty: 0, practice_time: Time.new(2018,4,22,11,0,0,'-04:00'))
        @swim_practice_1_april_4 = Practice.create(team: @w_swim, duration: 30, difficulty: 2, practice_time: Time.new(2018,4,21,13,0,0,'-04:00'))
        @swim_practice_1_april_3 = Practice.create(team: @w_swim, duration: 90, difficulty: 4, practice_time: Time.new(2018,4,20,12,0,0,'-04:00'))
        @swim_practice_1_april_2 = Practice.create(team: @w_swim, duration: 180, difficulty: 9, practice_time: Time.new(2018,4,19,19,0,0,'-04:00'))
        @swim_practice_2_april_1 = Practice.create(team: @w_swim, duration: 120, difficulty: 7, practice_time: Time.new(2018,4,18,16,0,0,'-04:00'))
        @swim_practice_1_april_1 = Practice.create(team: @w_swim, duration: 120, difficulty: 1, practice_time: Time.new(2018,4,17,6,0,0,'-04:00'))
        @swim_practice_1_march_31 = Practice.create(team: @w_swim, duration: 60, difficulty: 5, practice_time: Time.new(2018,4,16,16,30,0,'-04:00'))
        @swim_practice_1_march_30 = Practice.create(team: @w_swim, duration: 120, difficulty: 8, practice_time: Time.new(2018,4,15,16,0,0,'-04:00'))
  
        # Alec's post-practice surveys
  
        # March 30, 2018
        survey_post_1_march_30_service_alec  = SurveyService.new({user_id: @alec.id,team_id: @m_soccer.id,practice_id: @practice_1_march_30.id,survey_type: 'Post-Practice',datetime_today: Time.new(2018,4,15,23,59,59,'-04:00'),player_rpe_rating: 8,player_personal_performance: 8,participated_in_full_practice: true,minutes_participated: nil})
        @survey_post_1_march_30_alec = survey_post_1_march_30_service_alec.get_survey_object
  
        # March 31, 2018
        survey_post_1_march_31_service_alec = SurveyService.new({user_id: @alec.id,team_id: @m_soccer.id,practice_id: @practice_1_march_31.id,survey_type: 'Post-Practice',datetime_today: Time.new(2018,4,16,23,59,59,'-04:00'),player_rpe_rating: 6,player_personal_performance: 9,participated_in_full_practice: true,minutes_participated: nil})
        @survey_post_1_march_31_alec = survey_post_1_march_31_service_alec.get_survey_object
  
        # April 1, 2018 SESSION 1
        survey_post_1_april_1_service_alec  = SurveyService.new({user_id: @alec.id,team_id: @m_soccer.id,practice_id: @practice_1_april_1.id,survey_type: 'Post-Practice',datetime_today: Time.new(2018,4,17,23,59,59,'-04:00'),player_rpe_rating: 0,player_personal_performance: 4,participated_in_full_practice: true,minutes_participated: nil})
        @survey_post_1_april_1_alec = survey_post_1_april_1_service_alec.get_survey_object
  
        # April 1, 2018 SESSION 2
        survey_post_2_april_1_service_alec  = SurveyService.new({user_id: @alec.id,team_id: @m_soccer.id,practice_id: @practice_2_april_1.id,survey_type: 'Post-Practice',datetime_today: Time.new(2018,4,18,23,59,59,'-04:00'),player_rpe_rating: 5,player_personal_performance: 9,participated_in_full_practice: false,minutes_participated: 60})
        @survey_post_2_april_1_alec = survey_post_2_april_1_service_alec.get_survey_object
  
        # April 2, 2018
        survey_post_1_april_2_service_alec  = SurveyService.new({user_id: @alec.id,team_id: @m_soccer.id,practice_id: @practice_1_april_2.id,survey_type: 'Post-Practice',datetime_today: Time.new(2018,4,19,23,59,59,'-04:00'),player_rpe_rating: 5,player_personal_performance: 9,participated_in_full_practice: false,minutes_participated: 60})
        @survey_post_1_april_2_alec = survey_post_1_april_2_service_alec.get_survey_object
  
        # April 3, 2018
        survey_post_1_april_3_service_alec  = SurveyService.new({user_id: @alec.id,team_id: @m_soccer.id,practice_id: @practice_1_april_3.id,survey_type: 'Post-Practice',datetime_today: Time.new(2018,4,20,23,59,59,'-04:00'),player_rpe_rating: 3,player_personal_performance: 7,participated_in_full_practice: false,minutes_participated: 30})
        @survey_post_1_april_3_alec = survey_post_1_april_3_service_alec.get_survey_object
  
        # April 4, 2018
        survey_post_1_april_4_service_alec  = SurveyService.new({user_id: @alec.id,team_id: @m_soccer.id,practice_id: @practice_1_april_4.id,survey_type: 'Post-Practice',datetime_today: Time.new(2018,4,21,23,59,59,'-04:00'),player_rpe_rating: 3,player_personal_performance: 8,participated_in_full_practice: true,minutes_participated: nil})
        @survey_post_1_april_4_alec = survey_post_1_april_4_service_alec.get_survey_object
  
        # April 5, 2018 OFF DAY
        survey_post_1_april_5_service_alec  = SurveyService.new({user_id: @alec.id,team_id: @m_soccer.id,practice_id: @practice_1_april_5.id,survey_type: 'Post-Practice',datetime_today: Time.new(2018,4,22,23,59,59,'-04:00'),player_rpe_rating: 0,player_personal_performance: 0,participated_in_full_practice: true,minutes_participated: nil})
        @survey_post_1_april_5_alec = survey_post_1_april_5_service_alec.get_survey_object
  
        # April 6, 2018
        survey_post_1_april_6_service_alec = SurveyService.new({user_id: @alec.id,team_id: @m_soccer.id,practice_id: @practice_1_april_6.id,survey_type: 'Post-Practice',datetime_today: Time.new(2018,4,23,23,59,59,'-04:00'),player_rpe_rating: 5,player_personal_performance: 1,participated_in_full_practice: true,minutes_participated: nil})
        @survey_post_1_april_6_alec = survey_post_1_april_6_service_alec.get_survey_object
  
  
        # Alec's Daily Wellness Surveys
  
        # March 30, 2018
        survey_dw_march_30_service_alec = SurveyService.new({user_id: @alec.id,team_id: @m_soccer.id,survey_type: 'Daily Wellness',datetime_today: Time.new(2018,4,15,23,59,59,'-04:00'),hours_of_sleep: 2,quality_of_sleep: 3,academic_stress: 2,life_stress: 1,soreness: 3,ounces_of_water_consumed: 40,hydration_quality: false})
        @survey_dw_march_30_alec = survey_dw_march_30_service_alec.get_survey_object
  
        # March 31, 2018
        survey_dw_march_31_service_alec = SurveyService.new({user_id: @alec.id,team_id: @m_soccer.id,survey_type: 'Daily Wellness',datetime_today: Time.new(2018,4,16,23,59,59,'-04:00'),hours_of_sleep: 3,quality_of_sleep: 1,academic_stress: 4,life_stress: 2,soreness: 2,ounces_of_water_consumed: 50,hydration_quality: true})
        @survey_dw_march_31_alec = survey_dw_march_31_service_alec.get_survey_object
  
        # April 1, 2018
        survey_dw_april_1_service_alec = SurveyService.new({user_id: @alec.id,team_id: @m_soccer.id,survey_type: 'Daily Wellness',datetime_today: Time.new(2018,4,17,23,59,59,'-04:00'),hours_of_sleep: 1,quality_of_sleep: 2,academic_stress: 2,life_stress: 1,soreness: 1,ounces_of_water_consumed: 0,hydration_quality: false})
        @survey_dw_april_1_alec = survey_dw_april_1_service_alec.get_survey_object
  
        # April 2, 2018
        survey_dw_april_2_service_alec = SurveyService.new({user_id: @alec.id,team_id: @m_soccer.id,survey_type: 'Daily Wellness',datetime_today: Time.new(2018,4,18,23,59,59,'-04:00'),hours_of_sleep: 4,quality_of_sleep: 1,academic_stress: 1,life_stress: 1,soreness: 4,ounces_of_water_consumed: 20,hydration_quality: true})
        @survey_dw_april_2_alec = survey_dw_april_2_service_alec.get_survey_object
  
        # April 3, 2018
        survey_dw_april_3_service_alec = SurveyService.new({user_id: @alec.id,team_id: @m_soccer.id,survey_type: 'Daily Wellness',datetime_today: Time.new(2018,4,19,23,59,59,'-04:00'),hours_of_sleep: 1,quality_of_sleep: 1,academic_stress: 1,life_stress: 1,soreness: 1,ounces_of_water_consumed: 50,hydration_quality: false})
        @survey_dw_april_3_alec = survey_dw_april_3_service_alec.get_survey_object
  
        # April 4, 2018
        survey_dw_april_4_service_alec = SurveyService.new({user_id: @alec.id,team_id: @m_soccer.id,survey_type: 'Daily Wellness',datetime_today: Time.new(2018,4,20,23,59,59,'-04:00'),hours_of_sleep: 7,quality_of_sleep: 4,academic_stress: 3,life_stress: 4,soreness: 3,ounces_of_water_consumed: 90,hydration_quality: true})
        @survey_dw_april_4_alec = survey_dw_april_4_service_alec.get_survey_object
  
  
        # April 5, 2018
        survey_dw_april_5_service_alec = SurveyService.new({user_id: @alec.id,team_id: @m_soccer.id,survey_type: 'Daily Wellness',datetime_today: Time.new(2018,4,21,23,59,59,'-04:00'),hours_of_sleep: 6,quality_of_sleep: 2,academic_stress: 2,life_stress: 4,soreness: 2,ounces_of_water_consumed: 100,hydration_quality: true})
        @survey_dw_april_5_alec = survey_dw_april_5_service_alec.get_survey_object
  
        # April 6, 2018
        survey_dw_april_6_service_alec = SurveyService.new({user_id: @alec.id,team_id: @m_soccer.id,survey_type: 'Daily Wellness',datetime_today: Time.new(2018,4,22,23,59,59,'-04:00'),hours_of_sleep: 0,quality_of_sleep: 5,academic_stress: 1,life_stress: 1,soreness: 3,ounces_of_water_consumed: 12,hydration_quality: true})
        @survey_dw_april_6_alec = survey_dw_april_6_service_alec.get_survey_object
  
  
  
        # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
  
        # Greg's post-practice surveys
  
        # March 30, 2018
        survey_post_1_march_30_service_greg  = SurveyService.new({user_id: @greg.id,team_id: @m_soccer.id,practice_id: @practice_1_march_30.id,survey_type: 'Post-Practice',datetime_today: Time.new(2018,4,15,23,59,59,'-04:00'),player_rpe_rating: 7,player_personal_performance: 9,participated_in_full_practice: true,minutes_participated: nil})
        @survey_post_1_march_30_greg = survey_post_1_march_30_service_greg.get_survey_object
  
        # March 31, 2018
        survey_post_1_march_31_service_greg = SurveyService.new({user_id: @greg.id,team_id: @m_soccer.id,practice_id: @practice_1_march_31.id,survey_type: 'Post-Practice',datetime_today: Time.new(2018,4,16,23,59,59,'-04:00'),player_rpe_rating: 5,player_personal_performance: 8,participated_in_full_practice: true,minutes_participated: nil})
        @survey_post_1_march_31_greg = survey_post_1_march_31_service_greg.get_survey_object
  
        # April 1, 2018 SESSION 1
        survey_post_1_april_1_service_greg  = SurveyService.new({user_id: @greg.id,team_id: @m_soccer.id,practice_id: @practice_1_april_1.id,survey_type: 'Post-Practice',datetime_today: Time.new(2018,4,17,23,59,59,'-04:00'),player_rpe_rating: 1,player_personal_performance: 6,participated_in_full_practice: true,minutes_participated: nil})
        @survey_post_1_april_1_greg = survey_post_1_april_1_service_greg.get_survey_object
  
        # April 1, 2018 SESSION 2
        survey_post_2_april_1_service_greg  = SurveyService.new({user_id: @greg.id,team_id: @m_soccer.id,practice_id: @practice_2_april_1.id,survey_type: 'Post-Practice',datetime_today: Time.new(2018,4,18,23,59,59,'-04:00'),player_rpe_rating: 5,player_personal_performance: 9,participated_in_full_practice: false,minutes_participated: 70})
        @survey_post_2_april_1_greg = survey_post_2_april_1_service_greg.get_survey_object
  
        # April 2, 2018
        survey_post_1_april_2_service_greg  = SurveyService.new({user_id: @greg.id,team_id: @m_soccer.id,practice_id: @practice_1_april_2.id,survey_type: 'Post-Practice',datetime_today: Time.new(2018,4,19,23,59,59,'-04:00'),player_rpe_rating: 6,player_personal_performance: 8,participated_in_full_practice: false,minutes_participated: 50})
        @survey_post_1_april_2_greg = survey_post_1_april_2_service_greg.get_survey_object
  
        # April 3, 2018
        survey_post_1_april_3_service_greg  = SurveyService.new({user_id: @greg.id,team_id: @m_soccer.id,practice_id: @practice_1_april_3.id,survey_type: 'Post-Practice',datetime_today: Time.new(2018,4,20,23,59,59,'-04:00'),player_rpe_rating: 3,player_personal_performance: 9,participated_in_full_practice: false,minutes_participated: 30})
        @survey_post_1_april_3_greg = survey_post_1_april_3_service_greg.get_survey_object
  
        # April 4, 2018
        survey_post_1_april_4_service_greg  = SurveyService.new({user_id: @greg.id,team_id: @m_soccer.id,practice_id: @practice_1_april_4.id,survey_type: 'Post-Practice',datetime_today: Time.new(2018,4,21,23,59,59,'-04:00'),player_rpe_rating: 3,player_personal_performance: 7,participated_in_full_practice: true,minutes_participated: nil})
        @survey_post_1_april_4_greg = survey_post_1_april_4_service_greg.get_survey_object
  
        # April 5, 2018 OFF DAY
        survey_post_1_april_5_service_greg  = SurveyService.new({user_id: @greg.id,team_id: @m_soccer.id,practice_id: @practice_1_april_5.id,survey_type: 'Post-Practice',datetime_today: Time.new(2018,4,22,23,59,59,'-04:00'),player_rpe_rating: 0,player_personal_performance: 0,participated_in_full_practice: true,minutes_participated: nil})
        @survey_post_1_april_5_greg = survey_post_1_april_5_service_greg.get_survey_object
  
        # April 6, 2018
        survey_post_1_april_6_service_greg = SurveyService.new({user_id: @greg.id,team_id: @m_soccer.id,practice_id: @practice_1_april_6.id,survey_type: 'Post-Practice',datetime_today: Time.new(2018,4,23,23,59,59,'-04:00'),player_rpe_rating: 5,player_personal_performance: 3,participated_in_full_practice: true,minutes_participated: nil})
        @survey_post_1_april_6_greg = survey_post_1_april_6_service_greg.get_survey_object
  
  
        # Greg's Daily Wellness Surveys
  
        # March 30, 2018
        survey_dw_march_30_service_greg = SurveyService.new({user_id: @greg.id,team_id: @m_soccer.id,survey_type: 'Daily Wellness',datetime_today: Time.new(2018,4,15,23,59,59,'-04:00'),hours_of_sleep: 7,quality_of_sleep: 4,academic_stress: 2,life_stress: 3,soreness: 3,ounces_of_water_consumed: 40,hydration_quality: false})
        @survey_dw_march_30_greg = survey_dw_march_30_service_greg.get_survey_object
  
        # March 31, 2018
        survey_dw_march_31_service_greg = SurveyService.new({user_id: @greg.id,team_id: @m_soccer.id,survey_type: 'Daily Wellness',datetime_today: Time.new(2018,4,16,23,59,59,'-04:00'),hours_of_sleep: 6,quality_of_sleep: 3,academic_stress: 4,life_stress: 2,soreness: 2,ounces_of_water_consumed: 50,hydration_quality: true})
        @survey_dw_march_31_greg = survey_dw_march_31_service_greg.get_survey_object
  
        # April 1, 2018
        survey_dw_april_1_service_greg = SurveyService.new({user_id: @greg.id,team_id: @m_soccer.id,survey_type: 'Daily Wellness',datetime_today: Time.new(2018,4,17,23,59,59,'-04:00'),hours_of_sleep: 9,quality_of_sleep: 5,academic_stress: 4,life_stress: 4,soreness: 4,ounces_of_water_consumed: 120,hydration_quality: false})
        @survey_dw_april_1_greg = survey_dw_april_1_service_greg.get_survey_object
  
        # April 2, 2018
        survey_dw_april_2_service_greg = SurveyService.new({user_id: @greg.id,team_id: @m_soccer.id,survey_type: 'Daily Wellness',datetime_today: Time.new(2018,4,18,23,59,59,'-04:00'),hours_of_sleep: 8,quality_of_sleep: 3,academic_stress: 4,life_stress: 3,soreness: 4,ounces_of_water_consumed: 30,hydration_quality: false})
        @survey_dw_april_2_greg = survey_dw_april_2_service_greg.get_survey_object
  
        # April 3, 2018
        survey_dw_april_3_service_greg = SurveyService.new({user_id: @greg.id,team_id: @m_soccer.id,survey_type: 'Daily Wellness',datetime_today: Time.new(2018,4,19,23,59,59,'-04:00'),hours_of_sleep: 7,quality_of_sleep: 3,academic_stress: 2,life_stress: 1,soreness: 3,ounces_of_water_consumed: 20,hydration_quality: false})
        @survey_dw_april_3_greg = survey_dw_april_3_service_greg.get_survey_object
  
        # April 4, 2018
        survey_dw_april_4_service_greg = SurveyService.new({user_id: @greg.id,team_id: @m_soccer.id,survey_type: 'Daily Wellness',datetime_today: Time.new(2018,4,20,23,59,59,'-04:00'),hours_of_sleep: 7,quality_of_sleep: 2,academic_stress: 3,life_stress: 4,soreness: 2,ounces_of_water_consumed: 90,hydration_quality: true})
        @survey_dw_april_4_greg = survey_dw_april_4_service_greg.get_survey_object
  
  
        # April 5, 2018
        survey_dw_april_5_service_greg = SurveyService.new({user_id: @greg.id,team_id: @m_soccer.id,survey_type: 'Daily Wellness',datetime_today: Time.new(2018,4,21,23,59,59,'-04:00'),hours_of_sleep: 5,quality_of_sleep: 1,academic_stress: 1,life_stress: 2,soreness: 3,ounces_of_water_consumed: 100,hydration_quality: true})
        @survey_dw_april_5_greg = survey_dw_april_5_service_greg.get_survey_object
  
        # April 6, 2018
        survey_dw_april_6_service_greg = SurveyService.new({user_id: @greg.id,team_id: @m_soccer.id,survey_type: 'Daily Wellness',datetime_today: Time.new(2018,4,22,23,59,59,'-04:00'),hours_of_sleep: 7,quality_of_sleep: 3,academic_stress: 1,life_stress: 1,soreness: 3,ounces_of_water_consumed: 90,hydration_quality: true})
        @survey_dw_april_6_greg = survey_dw_april_6_service_greg.get_survey_object
  
        # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
  
        # zack's post-practice surveys
  
        # March 30, 2018
        survey_post_1_march_30_service_zack  = SurveyService.new({user_id: @zack.id,team_id: @m_soccer.id,practice_id: @practice_1_march_30.id,survey_type: 'Post-Practice',datetime_today: Time.new(2018,4,16,23,59,59,'-04:00'),player_rpe_rating: 6,player_personal_performance: 7,participated_in_full_practice: true,minutes_participated: nil})
        @survey_post_1_march_30_zack = survey_post_1_march_30_service_zack.get_survey_object
  
        # March 31, 2018
        survey_post_1_march_31_service_zack = SurveyService.new({user_id: @zack.id,team_id: @m_soccer.id,practice_id: @practice_1_march_31.id,survey_type: 'Post-Practice',datetime_today: Time.new(2018,4,17,23,59,59,'-04:00'),player_rpe_rating: 7,player_personal_performance: 8,participated_in_full_practice: true,minutes_participated: nil})
        @survey_post_1_march_31_zack = survey_post_1_march_31_service_zack.get_survey_object
  
        # April 1, 2018 SESSION 1
        survey_post_1_april_1_service_zack  = SurveyService.new({user_id: @zack.id,team_id: @m_soccer.id,practice_id: @practice_1_april_1.id,survey_type: 'Post-Practice',datetime_today: Time.new(2018,4,18,23,59,59,'-04:00'),player_rpe_rating: 6,player_personal_performance: 7,participated_in_full_practice: false,minutes_participated: 90})
        @survey_post_1_april_1_zack = survey_post_1_april_1_service_zack.get_survey_object
  
        # April 1, 2018 SESSION 2
        survey_post_2_april_1_service_zack  = SurveyService.new({user_id: @zack.id,team_id: @m_soccer.id,practice_id: @practice_2_april_1.id,survey_type: 'Post-Practice',datetime_today: Time.new(2018,4,19,23,59,59,'-04:00'),player_rpe_rating: 7,player_personal_performance: 7,participated_in_full_practice: true,minutes_participated: nil})
        @survey_post_2_april_1_zack = survey_post_2_april_1_service_zack.get_survey_object
  
        # April 2, 2018
        survey_post_1_april_2_service_zack  = SurveyService.new({user_id: @zack.id,team_id: @m_soccer.id,practice_id: @practice_1_april_2.id,survey_type: 'Post-Practice',datetime_today: Time.new(2018,4,20,23,59,59,'-04:00'),player_rpe_rating: 7,player_personal_performance: 9,participated_in_full_practice: true,minutes_participated: nil})
        @survey_post_1_april_2_zack = survey_post_1_april_2_service_zack.get_survey_object
  
        # April 3, 2018
        survey_post_1_april_3_service_zack  = SurveyService.new({user_id: @zack.id,team_id: @m_soccer.id,practice_id: @practice_1_april_3.id,survey_type: 'Post-Practice',datetime_today: Time.new(2018,4,21,23,59,59,'-04:00'),player_rpe_rating: 5,player_personal_performance: 7,participated_in_full_practice: true,minutes_participated: nil})
        @survey_post_1_april_3_zack = survey_post_1_april_3_service_zack.get_survey_object
  
        # April 4, 2018
        survey_post_1_april_4_service_zack  = SurveyService.new({user_id: @zack.id,team_id: @m_soccer.id,practice_id: @practice_1_april_4.id,survey_type: 'Post-Practice',datetime_today: Time.new(2018,4,22,23,59,59,'-04:00'),player_rpe_rating: 3,player_personal_performance: 8,participated_in_full_practice: false,minutes_participated: 15})
        @survey_post_1_april_4_zack = survey_post_1_april_4_service_zack.get_survey_object
  
        # April 5, 2018 OFF DAY
        survey_post_1_april_5_service_zack  = SurveyService.new({user_id: @zack.id,team_id: @m_soccer.id,practice_id: @practice_1_april_5.id,survey_type: 'Post-Practice',datetime_today: Time.new(2018,4,23,23,59,59,'-04:00'),player_rpe_rating: 0,player_personal_performance: 0,participated_in_full_practice: true,minutes_participated: nil})
        @survey_post_1_april_5_zack = survey_post_1_april_5_service_zack.get_survey_object
  
        # April 6, 2018
        survey_post_1_april_6_service_zack = SurveyService.new({user_id: @zack.id,team_id: @m_soccer.id,practice_id: @practice_1_april_6.id,survey_type: 'Post-Practice',datetime_today: Time.new(2018,4,15,23,59,59,'-04:00'),player_rpe_rating: 5,player_personal_performance: 9,participated_in_full_practice: true,minutes_participated: nil})
        @survey_post_1_april_6_zack = survey_post_1_april_6_service_zack.get_survey_object
  
  
        # zack's Daily Wellness Surveys
  
        # March 30, 2018
        survey_dw_march_30_service_zack = SurveyService.new({user_id: @zack.id,team_id: @m_soccer.id,survey_type: 'Daily Wellness',datetime_today: Time.new(2018,4,15,23,59,59,'-04:00'),hours_of_sleep: 5,quality_of_sleep: 3,academic_stress: 3,life_stress: 2,soreness: 2,ounces_of_water_consumed: 20,hydration_quality: false})
        @survey_dw_march_30_zack = survey_dw_march_30_service_zack.get_survey_object
  
        # March 31, 2018
        survey_dw_march_31_service_zack = SurveyService.new({user_id: @zack.id,team_id: @m_soccer.id,survey_type: 'Daily Wellness',datetime_today: Time.new(2018,4,17,23,59,59,'-04:00'),hours_of_sleep: 7,quality_of_sleep: 4,academic_stress: 3,life_stress: 2,soreness: 5,ounces_of_water_consumed: 90,hydration_quality: true})
        @survey_dw_march_31_zack = survey_dw_march_31_service_zack.get_survey_object
  
        # April 1, 2018
        survey_dw_april_1_service_zack = SurveyService.new({user_id: @zack.id,team_id: @m_soccer.id,survey_type: 'Daily Wellness',datetime_today: Time.new(2018,4,18,23,59,59,'-04:00'),hours_of_sleep: 4,quality_of_sleep: 2,academic_stress: 2,life_stress: 3,soreness: 1,ounces_of_water_consumed: 65,hydration_quality: true})
        @survey_dw_april_1_zack = survey_dw_april_1_service_zack.get_survey_object
  
        # April 2, 2018
        survey_dw_april_2_service_zack = SurveyService.new({user_id: @zack.id,team_id: @m_soccer.id,survey_type: 'Daily Wellness',datetime_today: Time.new(2018,4,19,23,59,59,'-04:00'),hours_of_sleep: 7,quality_of_sleep: 2,academic_stress: 2,life_stress: 3,soreness: 5,ounces_of_water_consumed: 80,hydration_quality: true})
        @survey_dw_april_2_zack = survey_dw_april_2_service_zack.get_survey_object
  
        # April 3, 2018
        survey_dw_april_3_service_zack = SurveyService.new({user_id: @zack.id,team_id: @m_soccer.id,survey_type: 'Daily Wellness',datetime_today: Time.new(2018,4,20,23,59,59,'-04:00'),hours_of_sleep: 3,quality_of_sleep: 1,academic_stress: 2,life_stress: 1,soreness: 4,ounces_of_water_consumed: 50,hydration_quality: true})
        @survey_dw_april_3_zack = survey_dw_april_3_service_zack.get_survey_object
  
        # April 4, 2018
        survey_dw_april_4_service_zack = SurveyService.new({user_id: @zack.id,team_id: @m_soccer.id,survey_type: 'Daily Wellness',datetime_today: Time.new(2018,4,21,23,59,59,'-04:00'),hours_of_sleep: 5,quality_of_sleep: 2,academic_stress: 1,life_stress: 1,soreness: 5,ounces_of_water_consumed: 20,hydration_quality: false})
        @survey_dw_april_4_zack = survey_dw_april_4_service_zack.get_survey_object
  
  
        # April 5, 2018
        survey_dw_april_5_service_zack = SurveyService.new({user_id: @zack.id,team_id: @m_soccer.id,survey_type: 'Daily Wellness',datetime_today: Time.new(2018,4,22,23,59,59,'-04:00'),hours_of_sleep: 6,quality_of_sleep: 1,academic_stress: 4,life_stress: 4,soreness: 2,ounces_of_water_consumed: 30,hydration_quality: false})
        @survey_dw_april_5_zack = survey_dw_april_5_service_zack.get_survey_object
  
        # April 6, 2018
        survey_dw_april_6_service_zack = SurveyService.new({user_id: @zack.id,team_id: @m_soccer.id,survey_type: 'Daily Wellness',datetime_today: Time.new(2018,4,23,23,59,59,'-04:00'),hours_of_sleep: 5,quality_of_sleep: 2,academic_stress: 4,life_stress: 1,soreness: 2,ounces_of_water_consumed: 50,hydration_quality: true})
        @survey_dw_april_6_zack = survey_dw_april_6_service_zack.get_survey_object
  
  
  
        # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
  
        # sam's post-practice surveys
  
        # March 30, 2018
        survey_post_1_march_30_service_sam  = SurveyService.new({user_id: @sam.id,team_id: @m_soccer.id,practice_id: @practice_1_march_30.id,survey_type: 'Post-Practice',datetime_today: Time.new(2018,4,15,23,59,59,'-04:00'),player_rpe_rating: 8,player_personal_performance: 3,participated_in_full_practice: true,minutes_participated: nil})
        @survey_post_1_march_30_sam = survey_post_1_march_30_service_sam.get_survey_object
  
        # March 31, 2018
        survey_post_1_march_31_service_sam = SurveyService.new({user_id: @sam.id,team_id: @m_soccer.id,practice_id: @practice_1_march_31.id,survey_type: 'Post-Practice',datetime_today: Time.new(2018,4,16,23,59,59,'-04:00'),player_rpe_rating: 8,player_personal_performance: 3,participated_in_full_practice: true,minutes_participated: nil})
        @survey_post_1_march_31_sam = survey_post_1_march_31_service_sam.get_survey_object
  
        # April 1, 2018 SESSION 1
        survey_post_1_april_1_service_sam  = SurveyService.new({user_id: @sam.id,team_id: @m_soccer.id,practice_id: @practice_1_april_1.id,survey_type: 'Post-Practice',datetime_today: Time.new(2018,4,17,23,59,59,'-04:00'),player_rpe_rating: 8,player_personal_performance: 5,participated_in_full_practice: false,minutes_participated: 80})
        @survey_post_1_april_1_sam = survey_post_1_april_1_service_sam.get_survey_object
  
        # April 1, 2018 SESSION 2
        survey_post_2_april_1_service_sam  = SurveyService.new({user_id: @sam.id,team_id: @m_soccer.id,practice_id: @practice_2_april_1.id,survey_type: 'Post-Practice',datetime_today: Time.new(2018,4,18,23,59,59,'-04:00'),player_rpe_rating: 8,player_personal_performance: 5,participated_in_full_practice: true,minutes_participated: nil})
        @survey_post_2_april_1_sam = survey_post_2_april_1_service_sam.get_survey_object
  
        # April 2, 2018
        survey_post_1_april_2_service_sam  = SurveyService.new({user_id: @sam.id,team_id: @m_soccer.id,practice_id: @practice_1_april_2.id,survey_type: 'Post-Practice',datetime_today: Time.new(2018,4,19,23,59,59,'-04:00'),player_rpe_rating: 8,player_personal_performance: 3,participated_in_full_practice: true,minutes_participated: nil})
        @survey_post_1_april_2_sam = survey_post_1_april_2_service_sam.get_survey_object
  
        # April 3, 2018
        survey_post_1_april_3_service_sam  = SurveyService.new({user_id: @sam.id,team_id: @m_soccer.id,practice_id: @practice_1_april_3.id,survey_type: 'Post-Practice',datetime_today: Time.new(2018,4,20,23,59,59,'-04:00'),player_rpe_rating: 7,player_personal_performance: 5,participated_in_full_practice: true,minutes_participated: nil})
        @survey_post_1_april_3_sam = survey_post_1_april_3_service_sam.get_survey_object
  
        # April 4, 2018
        survey_post_1_april_4_service_sam  = SurveyService.new({user_id: @sam.id,team_id: @m_soccer.id,practice_id: @practice_1_april_4.id,survey_type: 'Post-Practice',datetime_today: Time.new(2018,4,21,23,59,59,'-04:00'),player_rpe_rating: 5,player_personal_performance: 6,participated_in_full_practice: false,minutes_participated: 20})
        @survey_post_1_april_4_sam = survey_post_1_april_4_service_sam.get_survey_object
  
        # April 5, 2018 OFF DAY
        survey_post_1_april_5_service_sam  = SurveyService.new({user_id: @sam.id,team_id: @m_soccer.id,practice_id: @practice_1_april_5.id,survey_type: 'Post-Practice',datetime_today: Time.new(2018,4,22,23,59,59,'-04:00'),player_rpe_rating: 0,player_personal_performance: 0,participated_in_full_practice: true,minutes_participated: nil})
        @survey_post_1_april_5_sam = survey_post_1_april_5_service_sam.get_survey_object
  
        # April 6, 2018
        survey_post_1_april_6_service_sam = SurveyService.new({user_id: @sam.id,team_id: @m_soccer.id,practice_id: @practice_1_april_6.id,survey_type: 'Post-Practice',datetime_today: Time.new(2018,4,23,23,59,59,'-04:00'),player_rpe_rating: 7,player_personal_performance: 7,participated_in_full_practice: true,minutes_participated: nil})
        @survey_post_1_april_6_sam = survey_post_1_april_6_service_sam.get_survey_object
  
  
        # sam's Daily Wellness Surveys
  
        # March 30, 2018
        survey_dw_march_30_service_sam = SurveyService.new({user_id: @sam.id,team_id: @m_soccer.id,survey_type: 'Daily Wellness',datetime_today: Time.new(2018,4,15,23,59,59,'-04:00'),hours_of_sleep: 1,quality_of_sleep: 3,academic_stress: 2,life_stress: 1,soreness: 3,ounces_of_water_consumed: 10,hydration_quality: false})
        @survey_dw_march_30_sam = survey_dw_march_30_service_sam.get_survey_object
  
        # March 31, 2018
        survey_dw_march_31_service_sam = SurveyService.new({user_id: @sam.id,team_id: @m_soccer.id,survey_type: 'Daily Wellness',datetime_today: Time.new(2018,4,16,23,59,59,'-04:00'),hours_of_sleep: 2,quality_of_sleep: 2,academic_stress: 1,life_stress: 1,soreness: 2,ounces_of_water_consumed: 20,hydration_quality: true})
        @survey_dw_march_31_sam = survey_dw_march_31_service_sam.get_survey_object
  
        # April 1, 2018
        survey_dw_april_1_service_sam = SurveyService.new({user_id: @sam.id,team_id: @m_soccer.id,survey_type: 'Daily Wellness',datetime_today: Time.new(2018,4,17,23,59,59,'-04:00'),hours_of_sleep: 4,quality_of_sleep: 5,academic_stress: 3,life_stress: 2,soreness: 2,ounces_of_water_consumed: 25,hydration_quality: false})
        @survey_dw_april_1_sam = survey_dw_april_1_service_sam.get_survey_object
  
        # April 2, 2018
        survey_dw_april_2_service_sam = SurveyService.new({user_id: @sam.id,team_id: @m_soccer.id,survey_type: 'Daily Wellness',datetime_today: Time.new(2018,4,18,23,59,59,'-04:00'),hours_of_sleep: 3,quality_of_sleep: 1,academic_stress: 2,life_stress: 3,soreness: 2,ounces_of_water_consumed: 30,hydration_quality: true})
        @survey_dw_april_2_sam = survey_dw_april_2_service_sam.get_survey_object
  
        # April 3, 2018
        survey_dw_april_3_service_sam = SurveyService.new({user_id: @sam.id,team_id: @m_soccer.id,survey_type: 'Daily Wellness',datetime_today: Time.new(2018,4,19,23,59,59,'-04:00'),hours_of_sleep: 3,quality_of_sleep: 1,academic_stress: 2,life_stress: 1,soreness: 4,ounces_of_water_consumed: 50,hydration_quality: true})
        @survey_dw_april_3_sam = survey_dw_april_3_service_sam.get_survey_object
  
        # April 4, 2018
        survey_dw_april_4_service_sam = SurveyService.new({user_id: @sam.id,team_id: @m_soccer.id,survey_type: 'Daily Wellness',datetime_today: Time.new(2018,4,20,23,59,59,'-04:00'),hours_of_sleep: 4,quality_of_sleep: 5,academic_stress: 3,life_stress: 3,soreness: 2,ounces_of_water_consumed: 24,hydration_quality: true})
        @survey_dw_april_4_sam = survey_dw_april_4_service_sam.get_survey_object
  
  
        # April 5, 2018
        survey_dw_april_5_service_sam = SurveyService.new({user_id: @sam.id,team_id: @m_soccer.id,survey_type: 'Daily Wellness',datetime_today: Time.new(2018,4,21,23,59,59,'-04:00'),hours_of_sleep: 3,quality_of_sleep: 1,academic_stress: 3,life_stress: 3,soreness: 2,ounces_of_water_consumed: 15,hydration_quality: false})
        @survey_dw_april_5_sam = survey_dw_april_5_service_sam.get_survey_object
  
        # April 6, 2018
        survey_dw_april_6_service_sam = SurveyService.new({user_id: @sam.id,team_id: @m_soccer.id,survey_type: 'Daily Wellness',datetime_today: Time.new(2018,4,22,23,59,59,'-04:00'),hours_of_sleep: 4,quality_of_sleep: 2,academic_stress: 2,life_stress: 1,soreness: 3,ounces_of_water_consumed: 60,hydration_quality: true})
        @survey_dw_april_6_sam = survey_dw_april_6_service_sam.get_survey_object

        survey_dw_april_6_service_sam = SurveyService.new({user_id: @sam.id,team_id: @m_soccer.id,survey_type: 'Daily Wellness',datetime_today: Time.new(2018,4,23,23,59,59,'-04:00'),hours_of_sleep: 4,quality_of_sleep: 2,academic_stress: 2,life_stress: 1,soreness: 3,ounces_of_water_consumed: 60,hydration_quality: true})
        @survey_dw_april_6_sam = survey_dw_april_6_service_sam.get_survey_object
  
              # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
  
        # allie's post-practice surveys
  
        # March 30, 2018
        survey_post_1_march_30_service_allie  = SurveyService.new({user_id: @llie.id,team_id: @w_swim.id,practice_id: @swim_practice_1_march_30.id,survey_type: 'Post-Practice',datetime_today: Time.new(2018,4,15,23,59,59,'-04:00'),player_rpe_rating: 8,player_personal_performance: 3,participated_in_full_practice: true,minutes_participated: nil})
        @survey_post_1_march_30_allie = survey_post_1_march_30_service_allie.get_survey_object
  
        # March 31, 2018
        survey_post_1_march_31_service_allie = SurveyService.new({user_id: @llie.id,team_id: @w_swim.id,practice_id: @swim_practice_1_march_31.id,survey_type: 'Post-Practice',datetime_today: Time.new(2018,4,16,23,59,59,'-04:00'),player_rpe_rating: 8,player_personal_performance: 3,participated_in_full_practice: true,minutes_participated: nil})
        @survey_post_1_march_31_allie = survey_post_1_march_31_service_allie.get_survey_object
        
        # April 1, 2018 SESSION 1
        survey_post_1_april_1_service_allie  = SurveyService.new({user_id: @llie.id,team_id: @w_swim.id,practice_id: @swim_practice_1_april_1.id,survey_type: 'Post-Practice',datetime_today: Time.new(2018,4,17,23,59,59,'-04:00'),player_rpe_rating: 8,player_personal_performance: 5,participated_in_full_practice: false,minutes_participated: 80})
        @survey_post_1_april_1_allie = survey_post_1_april_1_service_allie.get_survey_object
        
        # April 1, 2018 SESSION 2
        survey_post_2_april_1_service_allie  = SurveyService.new({user_id: @llie.id,team_id: @w_swim.id,practice_id: @swim_practice_2_april_1.id,survey_type: 'Post-Practice',datetime_today: Time.new(2018,4,18,23,59,59,'-04:00'),player_rpe_rating: 8,player_personal_performance: 5,participated_in_full_practice: true,minutes_participated: nil})
        @survey_post_2_april_1_allie = survey_post_2_april_1_service_allie.get_survey_object
        
        # April 2, 2018
        survey_post_1_april_2_service_allie  = SurveyService.new({user_id: @llie.id,team_id: @w_swim.id,practice_id: @swim_practice_1_april_2.id,survey_type: 'Post-Practice',datetime_today: Time.new(2018,4,19,23,59,59,'-04:00'),player_rpe_rating: 8,player_personal_performance: 3,participated_in_full_practice: true,minutes_participated: nil})
        @survey_post_1_april_2_allie = survey_post_1_april_2_service_allie.get_survey_object
        
        # April 3, 2018
        survey_post_1_april_3_service_allie  = SurveyService.new({user_id: @llie.id,team_id: @w_swim.id,practice_id: @swim_practice_1_april_3.id,survey_type: 'Post-Practice',datetime_today: Time.new(2018,4,20,23,59,59,'-04:00'),player_rpe_rating: 7,player_personal_performance: 5,participated_in_full_practice: true,minutes_participated: nil})
        @survey_post_1_april_3_allie = survey_post_1_april_3_service_allie.get_survey_object
        
        # April 4, 2018
        survey_post_1_april_4_service_allie  = SurveyService.new({user_id: @llie.id,team_id: @w_swim.id,practice_id: @swim_practice_1_april_4.id,survey_type: 'Post-Practice',datetime_today: Time.new(2018,4,21,23,59,59,'-04:00'),player_rpe_rating: 5,player_personal_performance: 6,participated_in_full_practice: false,minutes_participated: 20})
        @survey_post_1_april_4_allie = survey_post_1_april_4_service_allie.get_survey_object
        
        # April 5, 2018 OFF DAY
        survey_post_1_april_5_service_allie  = SurveyService.new({user_id: @llie.id,team_id: @w_swim.id,practice_id: @swim_practice_1_april_5.id,survey_type: 'Post-Practice',datetime_today: Time.new(2018,4,22,23,59,59,'-04:00'),player_rpe_rating: 0,player_personal_performance: 0,participated_in_full_practice: true,minutes_participated: nil})
        @survey_post_1_april_5_allie = survey_post_1_april_5_service_allie.get_survey_object
        
        # April 6, 2018
        survey_post_1_april_6_service_allie = SurveyService.new({user_id: @llie.id,team_id: @w_swim.id,practice_id: @swim_practice_1_april_6.id,survey_type: 'Post-Practice',datetime_today: Time.new(2018,4,23,23,59,59,'-04:00'),player_rpe_rating: 7,player_personal_performance: 7,participated_in_full_practice: true,minutes_participated: nil})
        @survey_post_1_april_6_allie = survey_post_1_april_6_service_allie.get_survey_object
        
        
        # allie's Daily Wellness Surveys
        
        # March 30, 2018
        survey_dw_march_30_service_allie = SurveyService.new({user_id: @llie.id,team_id: @w_swim.id,survey_type: 'Daily Wellness',datetime_today: Time.new(2018,4,15,23,59,59,'-04:00'),hours_of_sleep: 1,quality_of_sleep: 3,academic_stress: 2,life_stress: 1,soreness: 3,ounces_of_water_consumed: 10,hydration_quality: false})
        @survey_dw_march_30_allie = survey_dw_march_30_service_allie.get_survey_object
        
        # March 31, 2018
        survey_dw_march_31_service_allie = SurveyService.new({user_id: @llie.id,team_id: @w_swim.id,survey_type: 'Daily Wellness',datetime_today: Time.new(2018,4,16,23,59,59,'-04:00'),hours_of_sleep: 2,quality_of_sleep: 2,academic_stress: 1,life_stress: 1,soreness: 2,ounces_of_water_consumed: 20,hydration_quality: true})
        @survey_dw_march_31_allie = survey_dw_march_31_service_allie.get_survey_object
        
        # April 1, 2018
        survey_dw_april_1_service_allie = SurveyService.new({user_id: @llie.id,team_id: @w_swim.id,survey_type: 'Daily Wellness',datetime_today: Time.new(2018,4,17,23,59,59,'-04:00'),hours_of_sleep: 4,quality_of_sleep: 5,academic_stress: 3,life_stress: 2,soreness: 2,ounces_of_water_consumed: 25,hydration_quality: false})
        @survey_dw_april_1_allie = survey_dw_april_1_service_allie.get_survey_object
        
        # April 2, 2018
        survey_dw_april_2_service_allie = SurveyService.new({user_id: @llie.id,team_id: @w_swim.id,survey_type: 'Daily Wellness',datetime_today: Time.new(2018,4,18,23,59,59,'-04:00'),hours_of_sleep: 3,quality_of_sleep: 1,academic_stress: 2,life_stress: 3,soreness: 2,ounces_of_water_consumed: 30,hydration_quality: true})
        @survey_dw_april_2_allie = survey_dw_april_2_service_allie.get_survey_object
        
        # April 3, 2018
        survey_dw_april_3_service_allie = SurveyService.new({user_id: @llie.id,team_id: @w_swim.id,survey_type: 'Daily Wellness',datetime_today: Time.new(2018,4,19,23,59,59,'-04:00'),hours_of_sleep: 3,quality_of_sleep: 1,academic_stress: 2,life_stress: 1,soreness: 4,ounces_of_water_consumed: 50,hydration_quality: true})
        @survey_dw_april_3_allie = survey_dw_april_3_service_allie.get_survey_object
        
        # April 4, 2018
        survey_dw_april_4_service_allie = SurveyService.new({user_id: @llie.id,team_id: @w_swim.id,survey_type: 'Daily Wellness',datetime_today: Time.new(2018,4,20,23,59,59,'-04:00'),hours_of_sleep: 4,quality_of_sleep: 5,academic_stress: 3,life_stress: 3,soreness: 2,ounces_of_water_consumed: 24,hydration_quality: true})
        @survey_dw_april_4_allie = survey_dw_april_4_service_allie.get_survey_object
        
        
        # April 5, 2018
        survey_dw_april_5_service_allie = SurveyService.new({user_id: @llie.id,team_id: @w_swim.id,survey_type: 'Daily Wellness',datetime_today: Time.new(2018,4,21,23,59,59,'-04:00'),hours_of_sleep: 3,quality_of_sleep: 1,academic_stress: 3,life_stress: 3,soreness: 2,ounces_of_water_consumed: 15,hydration_quality: false})
        @survey_dw_april_5_allie = survey_dw_april_5_service_allie.get_survey_object
        
        # April 6, 2018
        survey_dw_april_6_service_allie = SurveyService.new({user_id: @llie.id,team_id: @w_swim.id,survey_type: 'Daily Wellness',datetime_today: Time.new(2018,4,22,23,59,59,'-04:00'),hours_of_sleep: 4,quality_of_sleep: 2,academic_stress: 2,life_stress: 1,soreness: 3,ounces_of_water_consumed: 60,hydration_quality: true})
        @survey_dw_april_6_allie = survey_dw_april_6_service_allie.get_survey_object
        
        survey_dw_april_6_service_allie2 = SurveyService.new({user_id: @llie.id,team_id: @w_swim.id,survey_type: 'Daily Wellness',datetime_today: Time.new(2018,4,23,23,59,59,'-04:00'),hours_of_sleep: 4,quality_of_sleep: 2,academic_stress: 2,life_stress: 1,soreness: 3,ounces_of_water_consumed: 60,hydration_quality: true})
        @survey_dw_april_6_allie2 = survey_dw_april_6_service_allie2.get_survey_object
  
      end
  
  
      def delete_stuff
        @survey_post_1_march_30_alec.delete
        @survey_post_1_march_31_alec.delete
        @survey_post_2_april_1_alec.delete
        @survey_post_1_april_2_alec.delete
        @survey_post_1_april_3_alec.delete
        @survey_post_1_april_4_alec.delete
        @survey_post_1_april_5_alec.delete
        @survey_post_1_april_6_alec.delete
  
        @survey_dw_march_30_alec.delete
        @survey_dw_march_31_alec.delete
        @survey_dw_april_1_alec.delete
        @survey_dw_april_2_alec.delete
        @survey_dw_april_3_alec.delete
        @survey_dw_april_4_alec.delete
        @survey_dw_april_5_alec.delete
        @survey_dw_april_6_alec.delete
  
        @survey_post_1_march_30_greg.delete
        @survey_post_1_march_31_greg.delete
        @survey_post_2_april_1_greg.delete
        @survey_post_1_april_2_greg.delete
        @survey_post_1_april_3_greg.delete
        @survey_post_1_april_4_greg.delete
        @survey_post_1_april_5_greg.delete
        @survey_post_1_april_6_greg.delete
  
        @survey_dw_march_30_greg.delete
        @survey_dw_march_31_greg.delete
        @survey_dw_april_1_greg.delete
        @survey_dw_april_2_greg.delete
        @survey_dw_april_3_greg.delete
        @survey_dw_april_4_greg.delete
        @survey_dw_april_5_greg.delete
        @survey_dw_april_6_greg.delete
  
        @survey_post_1_march_30_zack.delete
        @survey_post_1_march_31_zack.delete
        @survey_post_2_april_1_zack.delete
        @survey_post_1_april_2_zack.delete
        @survey_post_1_april_3_zack.delete
        @survey_post_1_april_4_zack.delete
        @survey_post_1_april_5_zack.delete
        @survey_post_1_april_6_zack.delete
  
        @survey_dw_march_30_zack.delete
        @survey_dw_march_31_zack.delete
        @survey_dw_april_1_zack.delete
        @survey_dw_april_2_zack.delete
        @survey_dw_april_3_zack.delete
        @survey_dw_april_4_zack.delete
        @survey_dw_april_5_zack.delete
        @survey_dw_april_6_zack.delete
  
        @survey_post_1_march_30_sam.delete
        @survey_post_1_march_31_sam.delete
        @survey_post_2_april_1_sam.delete
        @survey_post_1_april_2_sam.delete
        @survey_post_1_april_3_sam.delete
        @survey_post_1_april_4_sam.delete
        @survey_post_1_april_5_sam.delete
        @survey_post_1_april_6_sam.delete
  
        @survey_dw_march_30_sam.delete
        @survey_dw_march_31_sam.delete
        @survey_dw_april_1_sam.delete
        @survey_dw_april_2_sam.delete
        @survey_dw_april_3_sam.delete
        @survey_dw_april_4_sam.delete
        @survey_dw_april_5_sam.delete
        @survey_dw_april_6_sam.delete
  
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
  
#   Survey.destroy_all
#   TeamAssignment.destroy_all
#   Practice.destroy_all
#   User.destroy_all
#   Team.destroy_all
  
  
#   load './app/services/survey_service_v2.rb'
  
  # get_survey_object
  