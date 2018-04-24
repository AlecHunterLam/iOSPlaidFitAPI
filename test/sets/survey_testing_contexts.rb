module Contexts
    module SurveyTestingContexts
# load './app/services/survey_service_v2.rb'
# Hirb.enable
# require './test/sets/survey_testing_contexts'
# include Contexts::SurveyTestingContexts
# create_stuff

      require 'faker'

      def create_teams_coaches_trainers
        # soccer team
        @m_soccer = Team.create(sport: "Soccer", gender: "Men", season: "Fall", active: true)
        # swim teams
        @m_swim = Team.create(sport: "Swimming & Diving", gender: "Men", season: "Winter", active: true)
        @w_swim = Team.create(sport: "Swimming & Diving", gender: "Women", season: "Winter", active: true)
        @soccer_coach = User.create(first_name: "Brandon", last_name: "Bowman", andrew_id: "bbowman", email: "bbowman@andrew.cmu.edu", major: "Other", phone: "1234567809", role: "Coach", active: true, year: "Other", password: "secret", password_confirmation: "secret")
        @swim_coach = User.create(first_name: "Matt", last_name: "Kinney", andrew_id: "mkinney", email: "mkinney@andrew.cmu.edu", major: "Other", phone: "9012345678", role: "Coach", active: true, year: "Other", password: "secret", password_confirmation: "secret")
        TeamAssignment.create(team: @m_soccer, user: @soccer_coach, active: true, date_added: Time.now)
        TeamAssignment.create(team: @m_swim, user: @swim_coach, active: true, date_added: Time.now)
        TeamAssignment.create(team: @w_swim, user: @swim_coach, active: true, date_added: Time.now)
        @trainer = User.create(first_name: "Adam", last_name: "May", andrew_id: "amay", email: "amay@andrew.cmu.edu", major: "Other", phone: "1234567809", role: "Athletic Trainer", active: true, year: "Other", password: "secret", password_confirmation: "secret")
        return [@m_soccer, @m_swim, @w_swim]
      end

      def create_players_and_team_assignments(teams)
        users = []
        teams.each do |team|
            # add 20 players to each team
            (1..20).each do |i|
                first_name = Faker::Name.first_name.gsub(/[^a-z ]/i, '')
                last_name = Faker::Name.last_name.gsub(/[^a-z ]/i, '')
                andrew_id = first_name[0,1] + last_name
                email = andrew_id.downcase + '@andrew.cmu.edu'
                major = ['Information Systems', 'Computer Science', 'Other', 'Engineering', 'Business'].sample
                phone = 10.times.map{rand(10)}.join
                role = "Player"
                active = true
                year = ['Freshman', 'Sophomore', 'Junior', 'Senior'].sample
                password = "secret"
                password_confirmation = "secret"
                user = User.create(first_name: first_name, last_name: last_name, andrew_id: andrew_id, email: email, major: major, phone: phone, role: role, active: active, year: year, password: password, password_confirmation: password_confirmation)
                TeamAssignment.create(team: team, user: user, active: true, date_added: Time.now)
                users.push(user)
            end
        end
        return users
      end
      
      def create_practices(teams)
        practices = []
        teams.each do |team|
            (0..6).each do |i|  
                duration = Faker::Number.between(0, 180)
                difficulty = Faker::Number.between(1, 10)
                practice_time = Time.new(2018, 4, 24 - i, Faker::Number.between(10, 18), [0, 30].sample, 0, '-04:00')
                practice = Practice.create(team: team, duration: duration, difficulty: difficulty, practice_time: practice_time)
                practices.push(practice)
            end
        end
        return practices
      end 

      def create_daily_wellness_surveys(users)
        users.each do |user|
            (0..6).each do |i|
                survey_service = SurveyService.new({user_id: user.id, team_id: user.team_assignments.first.team_id, survey_type: 'Daily Wellness', datetime_today: Time.new(2018, 4, 24 - i, 23, 59, 59, '-04:00'),
                                                    hours_of_sleep: Faker::Number.between(0, 12), quality_of_sleep: Faker::Number.between(1, 10), academic_stress: Faker::Number.between(1, 5), 
                                                    life_stress: Faker::Number.between(1, 5), soreness: Faker::Number.between(1, 10),ounces_of_water_consumed: Faker::Number.between(1, 128), hydration_quality: [true, false].sample})
                survey_service.get_survey_object
            end
        end
      end
      
      def create_post_practice_surveys(users, practices)
        users.each do |user|
            (0..6).each do |i|
                player_rpe_rating = Faker::Number.between(0, 10)
                player_personal_performance = Faker::Number.between(1, 10)
                datetime_today = Time.new(2018, 4, 24 - i, 23, 59, 59, '-04:00')
                # pracitce_id = 1
                # practice_duration = 100
                # practices.each do |practice|
                #     if practice.practice_time.strftime("%m/%d/%Y") == datetime_today.strftime("%m/%d/%Y")
                #         practice_id = practice.id
                #         practice_duration = practice.duration
                #         break
                #     end
                # end
                survey_service = SurveyService.new({user_id: user.id, team_id: user.team_assignments.first.team_id, practice_id: 1, survey_type: 'Post-Practice', datetime_today: datetime_today,
                                                   player_rpe_rating: player_rpe_rating, player_personal_performance: player_personal_performance, participated_in_full_practice: [true, false].sample,
                                                   minutes_participated: Faker::Number.between(0, 100)})
                survey_service.get_survey_object
            end
        end
      end

      def create_events
        (0..9).each do |i|
            Event.create(user_id: 2, description: "test event number " + i.to_s, event_time: Time.new(2018, 4, 24 + i, 23, 59, 59, '-04:00'))
        end
      end 

      def create_notifications
        (0..5).each do |i|
            Notification.create(user_id: i + 10, receiver_id: 2, priority: "Low", message: "test notification " + i.to_s, notified_time: Time.new(2018, 4, 24 - i, 23, 59, 59, '-04:00'))
        end
    end

      def create_stuff
        teams = create_teams_coaches_trainers
        users = create_players_and_team_assignments(teams)
        practices = create_practices(teams)
        create_daily_wellness_surveys(users)
        create_post_practice_surveys(users, practices)
        create_events
        create_notifications
      end

        # Alec's post-practice surveys
  
        # March 30, 2018
        # survey_post_1_march_30_service_alec  = SurveyService.new({user_id: @alec.id,team_id: @m_soccer.id,practice_id: @practice_1_march_30.id,survey_type: 'Post-Practice',datetime_today: Time.new(2018,4,15,23,59,59,'-04:00'),player_rpe_rating: 8,player_personal_performance: 8,participated_in_full_practice: true,minutes_participated: nil})
        # @survey_post_1_march_30_alec = survey_post_1_march_30_service_alec.get_survey_object
  
        # # March 31, 2018
        # survey_post_1_march_31_service_alec = SurveyService.new({user_id: @alec.id,team_id: @m_soccer.id,practice_id: @practice_1_march_31.id,survey_type: 'Post-Practice',datetime_today: Time.new(2018,4,16,23,59,59,'-04:00'),player_rpe_rating: 6,player_personal_performance: 9,participated_in_full_practice: true,minutes_participated: nil})
        # @survey_post_1_march_31_alec = survey_post_1_march_31_service_alec.get_survey_object
  
        # # April 1, 2018 SESSION 1
        # survey_post_1_april_1_service_alec  = SurveyService.new({user_id: @alec.id,team_id: @m_soccer.id,practice_id: @practice_1_april_1.id,survey_type: 'Post-Practice',datetime_today: Time.new(2018,4,17,23,59,59,'-04:00'),player_rpe_rating: 0,player_personal_performance: 4,participated_in_full_practice: true,minutes_participated: nil})
        # @survey_post_1_april_1_alec = survey_post_1_april_1_service_alec.get_survey_object
  
        # # April 1, 2018 SESSION 2
        # survey_post_2_april_1_service_alec  = SurveyService.new({user_id: @alec.id,team_id: @m_soccer.id,practice_id: @practice_2_april_1.id,survey_type: 'Post-Practice',datetime_today: Time.new(2018,4,18,23,59,59,'-04:00'),player_rpe_rating: 5,player_personal_performance: 9,participated_in_full_practice: false,minutes_participated: 60})
        # @survey_post_2_april_1_alec = survey_post_2_april_1_service_alec.get_survey_object
  
        # # April 2, 2018
        # survey_post_1_april_2_service_alec  = SurveyService.new({user_id: @alec.id,team_id: @m_soccer.id,practice_id: @practice_1_april_2.id,survey_type: 'Post-Practice',datetime_today: Time.new(2018,4,19,23,59,59,'-04:00'),player_rpe_rating: 5,player_personal_performance: 9,participated_in_full_practice: false,minutes_participated: 60})
        # @survey_post_1_april_2_alec = survey_post_1_april_2_service_alec.get_survey_object
  
        # # April 3, 2018
        # survey_post_1_april_3_service_alec  = SurveyService.new({user_id: @alec.id,team_id: @m_soccer.id,practice_id: @practice_1_april_3.id,survey_type: 'Post-Practice',datetime_today: Time.new(2018,4,20,23,59,59,'-04:00'),player_rpe_rating: 3,player_personal_performance: 7,participated_in_full_practice: false,minutes_participated: 30})
        # @survey_post_1_april_3_alec = survey_post_1_april_3_service_alec.get_survey_object
  
        # # April 4, 2018
        # survey_post_1_april_4_service_alec  = SurveyService.new({user_id: @alec.id,team_id: @m_soccer.id,practice_id: @practice_1_april_4.id,survey_type: 'Post-Practice',datetime_today: Time.new(2018,4,21,23,59,59,'-04:00'),player_rpe_rating: 3,player_personal_performance: 8,participated_in_full_practice: true,minutes_participated: nil})
        # @survey_post_1_april_4_alec = survey_post_1_april_4_service_alec.get_survey_object
  
        # # April 5, 2018 OFF DAY
        # survey_post_1_april_5_service_alec  = SurveyService.new({user_id: @alec.id,team_id: @m_soccer.id,practice_id: @practice_1_april_5.id,survey_type: 'Post-Practice',datetime_today: Time.new(2018,4,22,23,59,59,'-04:00'),player_rpe_rating: 0,player_personal_performance: 0,participated_in_full_practice: true,minutes_participated: nil})
        # @survey_post_1_april_5_alec = survey_post_1_april_5_service_alec.get_survey_object
  
        # # April 6, 2018
        # survey_post_1_april_6_service_alec = SurveyService.new({user_id: @alec.id,team_id: @m_soccer.id,practice_id: @practice_1_april_6.id,survey_type: 'Post-Practice',datetime_today: Time.new(2018,4,23,23,59,59,'-04:00'),player_rpe_rating: 5,player_personal_performance: 1,participated_in_full_practice: true,minutes_participated: nil})
        # @survey_post_1_april_6_alec = survey_post_1_april_6_service_alec.get_survey_object
  
  
        # # Alec's Daily Wellness Surveys
  
        # # March 30, 2018
        # survey_dw_march_30_service_alec = SurveyService.new({user_id: @alec.id,team_id: @m_soccer.id,survey_type: 'Daily Wellness',datetime_today: Time.new(2018,4,15,23,59,59,'-04:00'),hours_of_sleep: 2,quality_of_sleep: 3,academic_stress: 2,life_stress: 1,soreness: 3,ounces_of_water_consumed: 40,hydration_quality: false})
        # @survey_dw_march_30_alec = survey_dw_march_30_service_alec.get_survey_object
  
        # # March 31, 2018
        # survey_dw_march_31_service_alec = SurveyService.new({user_id: @alec.id,team_id: @m_soccer.id,survey_type: 'Daily Wellness',datetime_today: Time.new(2018,4,16,23,59,59,'-04:00'),hours_of_sleep: 3,quality_of_sleep: 1,academic_stress: 4,life_stress: 2,soreness: 2,ounces_of_water_consumed: 50,hydration_quality: true})
        # @survey_dw_march_31_alec = survey_dw_march_31_service_alec.get_survey_object
  
        # # April 1, 2018
        # survey_dw_april_1_service_alec = SurveyService.new({user_id: @alec.id,team_id: @m_soccer.id,survey_type: 'Daily Wellness',datetime_today: Time.new(2018,4,17,23,59,59,'-04:00'),hours_of_sleep: 1,quality_of_sleep: 2,academic_stress: 2,life_stress: 1,soreness: 1,ounces_of_water_consumed: 0,hydration_quality: false})
        # @survey_dw_april_1_alec = survey_dw_april_1_service_alec.get_survey_object
  
        # # April 2, 2018
        # survey_dw_april_2_service_alec = SurveyService.new({user_id: @alec.id,team_id: @m_soccer.id,survey_type: 'Daily Wellness',datetime_today: Time.new(2018,4,18,23,59,59,'-04:00'),hours_of_sleep: 4,quality_of_sleep: 1,academic_stress: 1,life_stress: 1,soreness: 4,ounces_of_water_consumed: 20,hydration_quality: true})
        # @survey_dw_april_2_alec = survey_dw_april_2_service_alec.get_survey_object
  
        # # April 3, 2018
        # survey_dw_april_3_service_alec = SurveyService.new({user_id: @alec.id,team_id: @m_soccer.id,survey_type: 'Daily Wellness',datetime_today: Time.new(2018,4,19,23,59,59,'-04:00'),hours_of_sleep: 1,quality_of_sleep: 1,academic_stress: 1,life_stress: 1,soreness: 1,ounces_of_water_consumed: 50,hydration_quality: false})
        # @survey_dw_april_3_alec = survey_dw_april_3_service_alec.get_survey_object
  
        # # April 4, 2018
        # survey_dw_april_4_service_alec = SurveyService.new({user_id: @alec.id,team_id: @m_soccer.id,survey_type: 'Daily Wellness',datetime_today: Time.new(2018,4,20,23,59,59,'-04:00'),hours_of_sleep: 7,quality_of_sleep: 4,academic_stress: 3,life_stress: 4,soreness: 3,ounces_of_water_consumed: 90,hydration_quality: true})
        # @survey_dw_april_4_alec = survey_dw_april_4_service_alec.get_survey_object
  
  
        # # April 5, 2018
        # survey_dw_april_5_service_alec = SurveyService.new({user_id: @alec.id,team_id: @m_soccer.id,survey_type: 'Daily Wellness',datetime_today: Time.new(2018,4,21,23,59,59,'-04:00'),hours_of_sleep: 6,quality_of_sleep: 2,academic_stress: 2,life_stress: 4,soreness: 2,ounces_of_water_consumed: 100,hydration_quality: true})
        # @survey_dw_april_5_alec = survey_dw_april_5_service_alec.get_survey_object
  
        # # April 6, 2018
        # survey_dw_april_6_service_alec = SurveyService.new({user_id: @alec.id,team_id: @m_soccer.id,survey_type: 'Daily Wellness',datetime_today: Time.new(2018,4,22,23,59,59,'-04:00'),hours_of_sleep: 0,quality_of_sleep: 5,academic_stress: 1,life_stress: 1,soreness: 3,ounces_of_water_consumed: 12,hydration_quality: true})
        # @survey_dw_april_6_alec = survey_dw_april_6_service_alec.get_survey_object
  
  
  
        # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
  
        # # Greg's post-practice surveys
  
        # # March 30, 2018
        # survey_post_1_march_30_service_greg  = SurveyService.new({user_id: @greg.id,team_id: @m_soccer.id,practice_id: @practice_1_march_30.id,survey_type: 'Post-Practice',datetime_today: Time.new(2018,4,15,23,59,59,'-04:00'),player_rpe_rating: 7,player_personal_performance: 9,participated_in_full_practice: true,minutes_participated: nil})
        # @survey_post_1_march_30_greg = survey_post_1_march_30_service_greg.get_survey_object
  
        # # March 31, 2018
        # survey_post_1_march_31_service_greg = SurveyService.new({user_id: @greg.id,team_id: @m_soccer.id,practice_id: @practice_1_march_31.id,survey_type: 'Post-Practice',datetime_today: Time.new(2018,4,16,23,59,59,'-04:00'),player_rpe_rating: 5,player_personal_performance: 8,participated_in_full_practice: true,minutes_participated: nil})
        # @survey_post_1_march_31_greg = survey_post_1_march_31_service_greg.get_survey_object
  
        # # April 1, 2018 SESSION 1
        # survey_post_1_april_1_service_greg  = SurveyService.new({user_id: @greg.id,team_id: @m_soccer.id,practice_id: @practice_1_april_1.id,survey_type: 'Post-Practice',datetime_today: Time.new(2018,4,17,23,59,59,'-04:00'),player_rpe_rating: 1,player_personal_performance: 6,participated_in_full_practice: true,minutes_participated: nil})
        # @survey_post_1_april_1_greg = survey_post_1_april_1_service_greg.get_survey_object
  
        # # April 1, 2018 SESSION 2
        # survey_post_2_april_1_service_greg  = SurveyService.new({user_id: @greg.id,team_id: @m_soccer.id,practice_id: @practice_2_april_1.id,survey_type: 'Post-Practice',datetime_today: Time.new(2018,4,18,23,59,59,'-04:00'),player_rpe_rating: 5,player_personal_performance: 9,participated_in_full_practice: false,minutes_participated: 70})
        # @survey_post_2_april_1_greg = survey_post_2_april_1_service_greg.get_survey_object
  
        # # April 2, 2018
        # survey_post_1_april_2_service_greg  = SurveyService.new({user_id: @greg.id,team_id: @m_soccer.id,practice_id: @practice_1_april_2.id,survey_type: 'Post-Practice',datetime_today: Time.new(2018,4,19,23,59,59,'-04:00'),player_rpe_rating: 6,player_personal_performance: 8,participated_in_full_practice: false,minutes_participated: 50})
        # @survey_post_1_april_2_greg = survey_post_1_april_2_service_greg.get_survey_object
  
        # # April 3, 2018
        # survey_post_1_april_3_service_greg  = SurveyService.new({user_id: @greg.id,team_id: @m_soccer.id,practice_id: @practice_1_april_3.id,survey_type: 'Post-Practice',datetime_today: Time.new(2018,4,20,23,59,59,'-04:00'),player_rpe_rating: 3,player_personal_performance: 9,participated_in_full_practice: false,minutes_participated: 30})
        # @survey_post_1_april_3_greg = survey_post_1_april_3_service_greg.get_survey_object
  
        # # April 4, 2018
        # survey_post_1_april_4_service_greg  = SurveyService.new({user_id: @greg.id,team_id: @m_soccer.id,practice_id: @practice_1_april_4.id,survey_type: 'Post-Practice',datetime_today: Time.new(2018,4,21,23,59,59,'-04:00'),player_rpe_rating: 3,player_personal_performance: 7,participated_in_full_practice: true,minutes_participated: nil})
        # @survey_post_1_april_4_greg = survey_post_1_april_4_service_greg.get_survey_object
  
        # # April 5, 2018 OFF DAY
        # survey_post_1_april_5_service_greg  = SurveyService.new({user_id: @greg.id,team_id: @m_soccer.id,practice_id: @practice_1_april_5.id,survey_type: 'Post-Practice',datetime_today: Time.new(2018,4,22,23,59,59,'-04:00'),player_rpe_rating: 0,player_personal_performance: 0,participated_in_full_practice: true,minutes_participated: nil})
        # @survey_post_1_april_5_greg = survey_post_1_april_5_service_greg.get_survey_object
  
        # # April 6, 2018
        # survey_post_1_april_6_service_greg = SurveyService.new({user_id: @greg.id,team_id: @m_soccer.id,practice_id: @practice_1_april_6.id,survey_type: 'Post-Practice',datetime_today: Time.new(2018,4,23,23,59,59,'-04:00'),player_rpe_rating: 5,player_personal_performance: 3,participated_in_full_practice: true,minutes_participated: nil})
        # @survey_post_1_april_6_greg = survey_post_1_april_6_service_greg.get_survey_object
  
  
        # # Greg's Daily Wellness Surveys
  
        # # March 30, 2018
        # survey_dw_march_30_service_greg = SurveyService.new({user_id: @greg.id,team_id: @m_soccer.id,survey_type: 'Daily Wellness',datetime_today: Time.new(2018,4,15,23,59,59,'-04:00'),hours_of_sleep: 7,quality_of_sleep: 4,academic_stress: 2,life_stress: 3,soreness: 3,ounces_of_water_consumed: 40,hydration_quality: false})
        # @survey_dw_march_30_greg = survey_dw_march_30_service_greg.get_survey_object
  
        # # March 31, 2018
        # survey_dw_march_31_service_greg = SurveyService.new({user_id: @greg.id,team_id: @m_soccer.id,survey_type: 'Daily Wellness',datetime_today: Time.new(2018,4,16,23,59,59,'-04:00'),hours_of_sleep: 6,quality_of_sleep: 3,academic_stress: 4,life_stress: 2,soreness: 2,ounces_of_water_consumed: 50,hydration_quality: true})
        # @survey_dw_march_31_greg = survey_dw_march_31_service_greg.get_survey_object
  
        # # April 1, 2018
        # survey_dw_april_1_service_greg = SurveyService.new({user_id: @greg.id,team_id: @m_soccer.id,survey_type: 'Daily Wellness',datetime_today: Time.new(2018,4,17,23,59,59,'-04:00'),hours_of_sleep: 9,quality_of_sleep: 5,academic_stress: 4,life_stress: 4,soreness: 4,ounces_of_water_consumed: 120,hydration_quality: false})
        # @survey_dw_april_1_greg = survey_dw_april_1_service_greg.get_survey_object
  
        # # April 2, 2018
        # survey_dw_april_2_service_greg = SurveyService.new({user_id: @greg.id,team_id: @m_soccer.id,survey_type: 'Daily Wellness',datetime_today: Time.new(2018,4,18,23,59,59,'-04:00'),hours_of_sleep: 8,quality_of_sleep: 3,academic_stress: 4,life_stress: 3,soreness: 4,ounces_of_water_consumed: 30,hydration_quality: false})
        # @survey_dw_april_2_greg = survey_dw_april_2_service_greg.get_survey_object
  
        # # April 3, 2018
        # survey_dw_april_3_service_greg = SurveyService.new({user_id: @greg.id,team_id: @m_soccer.id,survey_type: 'Daily Wellness',datetime_today: Time.new(2018,4,19,23,59,59,'-04:00'),hours_of_sleep: 7,quality_of_sleep: 3,academic_stress: 2,life_stress: 1,soreness: 3,ounces_of_water_consumed: 20,hydration_quality: false})
        # @survey_dw_april_3_greg = survey_dw_april_3_service_greg.get_survey_object
  
        # # April 4, 2018
        # survey_dw_april_4_service_greg = SurveyService.new({user_id: @greg.id,team_id: @m_soccer.id,survey_type: 'Daily Wellness',datetime_today: Time.new(2018,4,20,23,59,59,'-04:00'),hours_of_sleep: 7,quality_of_sleep: 2,academic_stress: 3,life_stress: 4,soreness: 2,ounces_of_water_consumed: 90,hydration_quality: true})
        # @survey_dw_april_4_greg = survey_dw_april_4_service_greg.get_survey_object
  
  
        # # April 5, 2018
        # survey_dw_april_5_service_greg = SurveyService.new({user_id: @greg.id,team_id: @m_soccer.id,survey_type: 'Daily Wellness',datetime_today: Time.new(2018,4,21,23,59,59,'-04:00'),hours_of_sleep: 5,quality_of_sleep: 1,academic_stress: 1,life_stress: 2,soreness: 3,ounces_of_water_consumed: 100,hydration_quality: true})
        # @survey_dw_april_5_greg = survey_dw_april_5_service_greg.get_survey_object
  
        # # April 6, 2018
        # survey_dw_april_6_service_greg = SurveyService.new({user_id: @greg.id,team_id: @m_soccer.id,survey_type: 'Daily Wellness',datetime_today: Time.new(2018,4,22,23,59,59,'-04:00'),hours_of_sleep: 7,quality_of_sleep: 3,academic_stress: 1,life_stress: 1,soreness: 3,ounces_of_water_consumed: 90,hydration_quality: true})
        # @survey_dw_april_6_greg = survey_dw_april_6_service_greg.get_survey_object
  
        # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
  
        # # zack's post-practice surveys
  
        # # March 30, 2018
        # survey_post_1_march_30_service_zack  = SurveyService.new({user_id: @zack.id,team_id: @m_soccer.id,practice_id: @practice_1_march_30.id,survey_type: 'Post-Practice',datetime_today: Time.new(2018,4,16,23,59,59,'-04:00'),player_rpe_rating: 6,player_personal_performance: 7,participated_in_full_practice: true,minutes_participated: nil})
        # @survey_post_1_march_30_zack = survey_post_1_march_30_service_zack.get_survey_object
  
        # # March 31, 2018
        # survey_post_1_march_31_service_zack = SurveyService.new({user_id: @zack.id,team_id: @m_soccer.id,practice_id: @practice_1_march_31.id,survey_type: 'Post-Practice',datetime_today: Time.new(2018,4,17,23,59,59,'-04:00'),player_rpe_rating: 7,player_personal_performance: 8,participated_in_full_practice: true,minutes_participated: nil})
        # @survey_post_1_march_31_zack = survey_post_1_march_31_service_zack.get_survey_object
  
        # # April 1, 2018 SESSION 1
        # survey_post_1_april_1_service_zack  = SurveyService.new({user_id: @zack.id,team_id: @m_soccer.id,practice_id: @practice_1_april_1.id,survey_type: 'Post-Practice',datetime_today: Time.new(2018,4,18,23,59,59,'-04:00'),player_rpe_rating: 6,player_personal_performance: 7,participated_in_full_practice: false,minutes_participated: 90})
        # @survey_post_1_april_1_zack = survey_post_1_april_1_service_zack.get_survey_object
  
        # # April 1, 2018 SESSION 2
        # survey_post_2_april_1_service_zack  = SurveyService.new({user_id: @zack.id,team_id: @m_soccer.id,practice_id: @practice_2_april_1.id,survey_type: 'Post-Practice',datetime_today: Time.new(2018,4,19,23,59,59,'-04:00'),player_rpe_rating: 7,player_personal_performance: 7,participated_in_full_practice: true,minutes_participated: nil})
        # @survey_post_2_april_1_zack = survey_post_2_april_1_service_zack.get_survey_object
  
        # # April 2, 2018
        # survey_post_1_april_2_service_zack  = SurveyService.new({user_id: @zack.id,team_id: @m_soccer.id,practice_id: @practice_1_april_2.id,survey_type: 'Post-Practice',datetime_today: Time.new(2018,4,20,23,59,59,'-04:00'),player_rpe_rating: 7,player_personal_performance: 9,participated_in_full_practice: true,minutes_participated: nil})
        # @survey_post_1_april_2_zack = survey_post_1_april_2_service_zack.get_survey_object
  
        # # April 3, 2018
        # survey_post_1_april_3_service_zack  = SurveyService.new({user_id: @zack.id,team_id: @m_soccer.id,practice_id: @practice_1_april_3.id,survey_type: 'Post-Practice',datetime_today: Time.new(2018,4,21,23,59,59,'-04:00'),player_rpe_rating: 5,player_personal_performance: 7,participated_in_full_practice: true,minutes_participated: nil})
        # @survey_post_1_april_3_zack = survey_post_1_april_3_service_zack.get_survey_object
  
        # # April 4, 2018
        # survey_post_1_april_4_service_zack  = SurveyService.new({user_id: @zack.id,team_id: @m_soccer.id,practice_id: @practice_1_april_4.id,survey_type: 'Post-Practice',datetime_today: Time.new(2018,4,22,23,59,59,'-04:00'),player_rpe_rating: 3,player_personal_performance: 8,participated_in_full_practice: false,minutes_participated: 15})
        # @survey_post_1_april_4_zack = survey_post_1_april_4_service_zack.get_survey_object
  
        # # April 5, 2018 OFF DAY
        # survey_post_1_april_5_service_zack  = SurveyService.new({user_id: @zack.id,team_id: @m_soccer.id,practice_id: @practice_1_april_5.id,survey_type: 'Post-Practice',datetime_today: Time.new(2018,4,23,23,59,59,'-04:00'),player_rpe_rating: 0,player_personal_performance: 0,participated_in_full_practice: true,minutes_participated: nil})
        # @survey_post_1_april_5_zack = survey_post_1_april_5_service_zack.get_survey_object
  
        # # April 6, 2018
        # survey_post_1_april_6_service_zack = SurveyService.new({user_id: @zack.id,team_id: @m_soccer.id,practice_id: @practice_1_april_6.id,survey_type: 'Post-Practice',datetime_today: Time.new(2018,4,15,23,59,59,'-04:00'),player_rpe_rating: 5,player_personal_performance: 9,participated_in_full_practice: true,minutes_participated: nil})
        # @survey_post_1_april_6_zack = survey_post_1_april_6_service_zack.get_survey_object
  
  
        # # zack's Daily Wellness Surveys
  
        # # March 30, 2018
        # survey_dw_march_30_service_zack = SurveyService.new({user_id: @zack.id,team_id: @m_soccer.id,survey_type: 'Daily Wellness',datetime_today: Time.new(2018,4,15,23,59,59,'-04:00'),hours_of_sleep: 5,quality_of_sleep: 3,academic_stress: 3,life_stress: 2,soreness: 2,ounces_of_water_consumed: 20,hydration_quality: false})
        # @survey_dw_march_30_zack = survey_dw_march_30_service_zack.get_survey_object
  
        # # March 31, 2018
        # survey_dw_march_31_service_zack = SurveyService.new({user_id: @zack.id,team_id: @m_soccer.id,survey_type: 'Daily Wellness',datetime_today: Time.new(2018,4,17,23,59,59,'-04:00'),hours_of_sleep: 7,quality_of_sleep: 4,academic_stress: 3,life_stress: 2,soreness: 5,ounces_of_water_consumed: 90,hydration_quality: true})
        # @survey_dw_march_31_zack = survey_dw_march_31_service_zack.get_survey_object
  
        # # April 1, 2018
        # survey_dw_april_1_service_zack = SurveyService.new({user_id: @zack.id,team_id: @m_soccer.id,survey_type: 'Daily Wellness',datetime_today: Time.new(2018,4,18,23,59,59,'-04:00'),hours_of_sleep: 4,quality_of_sleep: 2,academic_stress: 2,life_stress: 3,soreness: 1,ounces_of_water_consumed: 65,hydration_quality: true})
        # @survey_dw_april_1_zack = survey_dw_april_1_service_zack.get_survey_object
  
        # # April 2, 2018
        # survey_dw_april_2_service_zack = SurveyService.new({user_id: @zack.id,team_id: @m_soccer.id,survey_type: 'Daily Wellness',datetime_today: Time.new(2018,4,19,23,59,59,'-04:00'),hours_of_sleep: 7,quality_of_sleep: 2,academic_stress: 2,life_stress: 3,soreness: 5,ounces_of_water_consumed: 80,hydration_quality: true})
        # @survey_dw_april_2_zack = survey_dw_april_2_service_zack.get_survey_object
  
        # # April 3, 2018
        # survey_dw_april_3_service_zack = SurveyService.new({user_id: @zack.id,team_id: @m_soccer.id,survey_type: 'Daily Wellness',datetime_today: Time.new(2018,4,20,23,59,59,'-04:00'),hours_of_sleep: 3,quality_of_sleep: 1,academic_stress: 2,life_stress: 1,soreness: 4,ounces_of_water_consumed: 50,hydration_quality: true})
        # @survey_dw_april_3_zack = survey_dw_april_3_service_zack.get_survey_object
  
        # # April 4, 2018
        # survey_dw_april_4_service_zack = SurveyService.new({user_id: @zack.id,team_id: @m_soccer.id,survey_type: 'Daily Wellness',datetime_today: Time.new(2018,4,21,23,59,59,'-04:00'),hours_of_sleep: 5,quality_of_sleep: 2,academic_stress: 1,life_stress: 1,soreness: 5,ounces_of_water_consumed: 20,hydration_quality: false})
        # @survey_dw_april_4_zack = survey_dw_april_4_service_zack.get_survey_object
  
  
        # # April 5, 2018
        # survey_dw_april_5_service_zack = SurveyService.new({user_id: @zack.id,team_id: @m_soccer.id,survey_type: 'Daily Wellness',datetime_today: Time.new(2018,4,22,23,59,59,'-04:00'),hours_of_sleep: 6,quality_of_sleep: 1,academic_stress: 4,life_stress: 4,soreness: 2,ounces_of_water_consumed: 30,hydration_quality: false})
        # @survey_dw_april_5_zack = survey_dw_april_5_service_zack.get_survey_object
  
        # # April 6, 2018
        # survey_dw_april_6_service_zack = SurveyService.new({user_id: @zack.id,team_id: @m_soccer.id,survey_type: 'Daily Wellness',datetime_today: Time.new(2018,4,23,23,59,59,'-04:00'),hours_of_sleep: 5,quality_of_sleep: 2,academic_stress: 4,life_stress: 1,soreness: 2,ounces_of_water_consumed: 50,hydration_quality: true})
        # @survey_dw_april_6_zack = survey_dw_april_6_service_zack.get_survey_object
  
  
  
        # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
  
        # # sam's post-practice surveys
  
        # # March 30, 2018
        # survey_post_1_march_30_service_sam  = SurveyService.new({user_id: @sam.id,team_id: @m_soccer.id,practice_id: @practice_1_march_30.id,survey_type: 'Post-Practice',datetime_today: Time.new(2018,4,15,23,59,59,'-04:00'),player_rpe_rating: 8,player_personal_performance: 3,participated_in_full_practice: true,minutes_participated: nil})
        # @survey_post_1_march_30_sam = survey_post_1_march_30_service_sam.get_survey_object
  
        # # March 31, 2018
        # survey_post_1_march_31_service_sam = SurveyService.new({user_id: @sam.id,team_id: @m_soccer.id,practice_id: @practice_1_march_31.id,survey_type: 'Post-Practice',datetime_today: Time.new(2018,4,16,23,59,59,'-04:00'),player_rpe_rating: 8,player_personal_performance: 3,participated_in_full_practice: true,minutes_participated: nil})
        # @survey_post_1_march_31_sam = survey_post_1_march_31_service_sam.get_survey_object
  
        # # April 1, 2018 SESSION 1
        # survey_post_1_april_1_service_sam  = SurveyService.new({user_id: @sam.id,team_id: @m_soccer.id,practice_id: @practice_1_april_1.id,survey_type: 'Post-Practice',datetime_today: Time.new(2018,4,17,23,59,59,'-04:00'),player_rpe_rating: 8,player_personal_performance: 5,participated_in_full_practice: false,minutes_participated: 80})
        # @survey_post_1_april_1_sam = survey_post_1_april_1_service_sam.get_survey_object
  
        # # April 1, 2018 SESSION 2
        # survey_post_2_april_1_service_sam  = SurveyService.new({user_id: @sam.id,team_id: @m_soccer.id,practice_id: @practice_2_april_1.id,survey_type: 'Post-Practice',datetime_today: Time.new(2018,4,18,23,59,59,'-04:00'),player_rpe_rating: 8,player_personal_performance: 5,participated_in_full_practice: true,minutes_participated: nil})
        # @survey_post_2_april_1_sam = survey_post_2_april_1_service_sam.get_survey_object
  
        # # April 2, 2018
        # survey_post_1_april_2_service_sam  = SurveyService.new({user_id: @sam.id,team_id: @m_soccer.id,practice_id: @practice_1_april_2.id,survey_type: 'Post-Practice',datetime_today: Time.new(2018,4,19,23,59,59,'-04:00'),player_rpe_rating: 8,player_personal_performance: 3,participated_in_full_practice: true,minutes_participated: nil})
        # @survey_post_1_april_2_sam = survey_post_1_april_2_service_sam.get_survey_object
  
        # # April 3, 2018
        # survey_post_1_april_3_service_sam  = SurveyService.new({user_id: @sam.id,team_id: @m_soccer.id,practice_id: @practice_1_april_3.id,survey_type: 'Post-Practice',datetime_today: Time.new(2018,4,20,23,59,59,'-04:00'),player_rpe_rating: 7,player_personal_performance: 5,participated_in_full_practice: true,minutes_participated: nil})
        # @survey_post_1_april_3_sam = survey_post_1_april_3_service_sam.get_survey_object
  
        # # April 4, 2018
        # survey_post_1_april_4_service_sam  = SurveyService.new({user_id: @sam.id,team_id: @m_soccer.id,practice_id: @practice_1_april_4.id,survey_type: 'Post-Practice',datetime_today: Time.new(2018,4,21,23,59,59,'-04:00'),player_rpe_rating: 5,player_personal_performance: 6,participated_in_full_practice: false,minutes_participated: 20})
        # @survey_post_1_april_4_sam = survey_post_1_april_4_service_sam.get_survey_object
  
        # # April 5, 2018 OFF DAY
        # survey_post_1_april_5_service_sam  = SurveyService.new({user_id: @sam.id,team_id: @m_soccer.id,practice_id: @practice_1_april_5.id,survey_type: 'Post-Practice',datetime_today: Time.new(2018,4,22,23,59,59,'-04:00'),player_rpe_rating: 0,player_personal_performance: 0,participated_in_full_practice: true,minutes_participated: nil})
        # @survey_post_1_april_5_sam = survey_post_1_april_5_service_sam.get_survey_object
  
        # # April 6, 2018
        # survey_post_1_april_6_service_sam = SurveyService.new({user_id: @sam.id,team_id: @m_soccer.id,practice_id: @practice_1_april_6.id,survey_type: 'Post-Practice',datetime_today: Time.new(2018,4,23,23,59,59,'-04:00'),player_rpe_rating: 7,player_personal_performance: 7,participated_in_full_practice: true,minutes_participated: nil})
        # @survey_post_1_april_6_sam = survey_post_1_april_6_service_sam.get_survey_object
  
  
        # # sam's Daily Wellness Surveys
  
        # # March 30, 2018
        # survey_dw_march_30_service_sam = SurveyService.new({user_id: @sam.id,team_id: @m_soccer.id,survey_type: 'Daily Wellness',datetime_today: Time.new(2018,4,15,23,59,59,'-04:00'),hours_of_sleep: 1,quality_of_sleep: 3,academic_stress: 2,life_stress: 1,soreness: 3,ounces_of_water_consumed: 10,hydration_quality: false})
        # @survey_dw_march_30_sam = survey_dw_march_30_service_sam.get_survey_object
  
        # # March 31, 2018
        # survey_dw_march_31_service_sam = SurveyService.new({user_id: @sam.id,team_id: @m_soccer.id,survey_type: 'Daily Wellness',datetime_today: Time.new(2018,4,16,23,59,59,'-04:00'),hours_of_sleep: 2,quality_of_sleep: 2,academic_stress: 1,life_stress: 1,soreness: 2,ounces_of_water_consumed: 20,hydration_quality: true})
        # @survey_dw_march_31_sam = survey_dw_march_31_service_sam.get_survey_object
  
        # # April 1, 2018
        # survey_dw_april_1_service_sam = SurveyService.new({user_id: @sam.id,team_id: @m_soccer.id,survey_type: 'Daily Wellness',datetime_today: Time.new(2018,4,17,23,59,59,'-04:00'),hours_of_sleep: 4,quality_of_sleep: 5,academic_stress: 3,life_stress: 2,soreness: 2,ounces_of_water_consumed: 25,hydration_quality: false})
        # @survey_dw_april_1_sam = survey_dw_april_1_service_sam.get_survey_object
  
        # # April 2, 2018
        # survey_dw_april_2_service_sam = SurveyService.new({user_id: @sam.id,team_id: @m_soccer.id,survey_type: 'Daily Wellness',datetime_today: Time.new(2018,4,18,23,59,59,'-04:00'),hours_of_sleep: 3,quality_of_sleep: 1,academic_stress: 2,life_stress: 3,soreness: 2,ounces_of_water_consumed: 30,hydration_quality: true})
        # @survey_dw_april_2_sam = survey_dw_april_2_service_sam.get_survey_object
  
        # # April 3, 2018
        # survey_dw_april_3_service_sam = SurveyService.new({user_id: @sam.id,team_id: @m_soccer.id,survey_type: 'Daily Wellness',datetime_today: Time.new(2018,4,19,23,59,59,'-04:00'),hours_of_sleep: 3,quality_of_sleep: 1,academic_stress: 2,life_stress: 1,soreness: 4,ounces_of_water_consumed: 50,hydration_quality: true})
        # @survey_dw_april_3_sam = survey_dw_april_3_service_sam.get_survey_object
  
        # # April 4, 2018
        # survey_dw_april_4_service_sam = SurveyService.new({user_id: @sam.id,team_id: @m_soccer.id,survey_type: 'Daily Wellness',datetime_today: Time.new(2018,4,20,23,59,59,'-04:00'),hours_of_sleep: 4,quality_of_sleep: 5,academic_stress: 3,life_stress: 3,soreness: 2,ounces_of_water_consumed: 24,hydration_quality: true})
        # @survey_dw_april_4_sam = survey_dw_april_4_service_sam.get_survey_object
  
  
        # # April 5, 2018
        # survey_dw_april_5_service_sam = SurveyService.new({user_id: @sam.id,team_id: @m_soccer.id,survey_type: 'Daily Wellness',datetime_today: Time.new(2018,4,21,23,59,59,'-04:00'),hours_of_sleep: 3,quality_of_sleep: 1,academic_stress: 3,life_stress: 3,soreness: 2,ounces_of_water_consumed: 15,hydration_quality: false})
        # @survey_dw_april_5_sam = survey_dw_april_5_service_sam.get_survey_object
  
        # # April 6, 2018
        # survey_dw_april_6_service_sam = SurveyService.new({user_id: @sam.id,team_id: @m_soccer.id,survey_type: 'Daily Wellness',datetime_today: Time.new(2018,4,22,23,59,59,'-04:00'),hours_of_sleep: 4,quality_of_sleep: 2,academic_stress: 2,life_stress: 1,soreness: 3,ounces_of_water_consumed: 60,hydration_quality: true})
        # @survey_dw_april_6_sam = survey_dw_april_6_service_sam.get_survey_object

        # survey_dw_april_6_service_sam = SurveyService.new({user_id: @sam.id,team_id: @m_soccer.id,survey_type: 'Daily Wellness',datetime_today: Time.new(2018,4,23,23,59,59,'-04:00'),hours_of_sleep: 4,quality_of_sleep: 2,academic_stress: 2,life_stress: 1,soreness: 3,ounces_of_water_consumed: 60,hydration_quality: true})
        # @survey_dw_april_6_sam = survey_dw_april_6_service_sam.get_survey_object
  
        #       # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
  
        # # allie's post-practice surveys
  
        # # March 30, 2018
        # survey_post_1_march_30_service_allie  = SurveyService.new({user_id: @llie.id,team_id: @w_swim.id,practice_id: @swim_practice_1_march_30.id,survey_type: 'Post-Practice',datetime_today: Time.new(2018,4,15,23,59,59,'-04:00'),player_rpe_rating: 8,player_personal_performance: 3,participated_in_full_practice: true,minutes_participated: nil})
        # @survey_post_1_march_30_allie = survey_post_1_march_30_service_allie.get_survey_object
  
        # # March 31, 2018
        # survey_post_1_march_31_service_allie = SurveyService.new({user_id: @llie.id,team_id: @w_swim.id,practice_id: @swim_practice_1_march_31.id,survey_type: 'Post-Practice',datetime_today: Time.new(2018,4,16,23,59,59,'-04:00'),player_rpe_rating: 8,player_personal_performance: 3,participated_in_full_practice: true,minutes_participated: nil})
        # @survey_post_1_march_31_allie = survey_post_1_march_31_service_allie.get_survey_object
        
        # # April 1, 2018 SESSION 1
        # survey_post_1_april_1_service_allie  = SurveyService.new({user_id: @llie.id,team_id: @w_swim.id,practice_id: @swim_practice_1_april_1.id,survey_type: 'Post-Practice',datetime_today: Time.new(2018,4,17,23,59,59,'-04:00'),player_rpe_rating: 8,player_personal_performance: 5,participated_in_full_practice: false,minutes_participated: 80})
        # @survey_post_1_april_1_allie = survey_post_1_april_1_service_allie.get_survey_object
        
        # # April 1, 2018 SESSION 2
        # survey_post_2_april_1_service_allie  = SurveyService.new({user_id: @llie.id,team_id: @w_swim.id,practice_id: @swim_practice_2_april_1.id,survey_type: 'Post-Practice',datetime_today: Time.new(2018,4,18,23,59,59,'-04:00'),player_rpe_rating: 8,player_personal_performance: 5,participated_in_full_practice: true,minutes_participated: nil})
        # @survey_post_2_april_1_allie = survey_post_2_april_1_service_allie.get_survey_object
        
        # # April 2, 2018
        # survey_post_1_april_2_service_allie  = SurveyService.new({user_id: @llie.id,team_id: @w_swim.id,practice_id: @swim_practice_1_april_2.id,survey_type: 'Post-Practice',datetime_today: Time.new(2018,4,19,23,59,59,'-04:00'),player_rpe_rating: 8,player_personal_performance: 3,participated_in_full_practice: true,minutes_participated: nil})
        # @survey_post_1_april_2_allie = survey_post_1_april_2_service_allie.get_survey_object
        
        # # April 3, 2018
        # survey_post_1_april_3_service_allie  = SurveyService.new({user_id: @llie.id,team_id: @w_swim.id,practice_id: @swim_practice_1_april_3.id,survey_type: 'Post-Practice',datetime_today: Time.new(2018,4,20,23,59,59,'-04:00'),player_rpe_rating: 7,player_personal_performance: 5,participated_in_full_practice: true,minutes_participated: nil})
        # @survey_post_1_april_3_allie = survey_post_1_april_3_service_allie.get_survey_object
        
        # # April 4, 2018
        # survey_post_1_april_4_service_allie  = SurveyService.new({user_id: @llie.id,team_id: @w_swim.id,practice_id: @swim_practice_1_april_4.id,survey_type: 'Post-Practice',datetime_today: Time.new(2018,4,21,23,59,59,'-04:00'),player_rpe_rating: 5,player_personal_performance: 6,participated_in_full_practice: false,minutes_participated: 20})
        # @survey_post_1_april_4_allie = survey_post_1_april_4_service_allie.get_survey_object
        
        # # April 5, 2018 OFF DAY
        # survey_post_1_april_5_service_allie  = SurveyService.new({user_id: @llie.id,team_id: @w_swim.id,practice_id: @swim_practice_1_april_5.id,survey_type: 'Post-Practice',datetime_today: Time.new(2018,4,22,23,59,59,'-04:00'),player_rpe_rating: 0,player_personal_performance: 0,participated_in_full_practice: true,minutes_participated: nil})
        # @survey_post_1_april_5_allie = survey_post_1_april_5_service_allie.get_survey_object
        
        # # April 6, 2018
        # survey_post_1_april_6_service_allie = SurveyService.new({user_id: @llie.id,team_id: @w_swim.id,practice_id: @swim_practice_1_april_6.id,survey_type: 'Post-Practice',datetime_today: Time.new(2018,4,23,23,59,59,'-04:00'),player_rpe_rating: 7,player_personal_performance: 7,participated_in_full_practice: true,minutes_participated: nil})
        # @survey_post_1_april_6_allie = survey_post_1_april_6_service_allie.get_survey_object
        
        
        # # allie's Daily Wellness Surveys
        
        # # March 30, 2018
        # survey_dw_march_30_service_allie = SurveyService.new({user_id: @llie.id,team_id: @w_swim.id,survey_type: 'Daily Wellness',datetime_today: Time.new(2018,4,15,23,59,59,'-04:00'),hours_of_sleep: 1,quality_of_sleep: 3,academic_stress: 2,life_stress: 1,soreness: 3,ounces_of_water_consumed: 10,hydration_quality: false})
        # @survey_dw_march_30_allie = survey_dw_march_30_service_allie.get_survey_object
        
        # # March 31, 2018
        # survey_dw_march_31_service_allie = SurveyService.new({user_id: @llie.id,team_id: @w_swim.id,survey_type: 'Daily Wellness',datetime_today: Time.new(2018,4,16,23,59,59,'-04:00'),hours_of_sleep: 2,quality_of_sleep: 2,academic_stress: 1,life_stress: 1,soreness: 2,ounces_of_water_consumed: 20,hydration_quality: true})
        # @survey_dw_march_31_allie = survey_dw_march_31_service_allie.get_survey_object
        
        # # April 1, 2018
        # survey_dw_april_1_service_allie = SurveyService.new({user_id: @llie.id,team_id: @w_swim.id,survey_type: 'Daily Wellness',datetime_today: Time.new(2018,4,17,23,59,59,'-04:00'),hours_of_sleep: 4,quality_of_sleep: 5,academic_stress: 3,life_stress: 2,soreness: 2,ounces_of_water_consumed: 25,hydration_quality: false})
        # @survey_dw_april_1_allie = survey_dw_april_1_service_allie.get_survey_object
        
        # # April 2, 2018
        # survey_dw_april_2_service_allie = SurveyService.new({user_id: @llie.id,team_id: @w_swim.id,survey_type: 'Daily Wellness',datetime_today: Time.new(2018,4,18,23,59,59,'-04:00'),hours_of_sleep: 3,quality_of_sleep: 1,academic_stress: 2,life_stress: 3,soreness: 2,ounces_of_water_consumed: 30,hydration_quality: true})
        # @survey_dw_april_2_allie = survey_dw_april_2_service_allie.get_survey_object
        
        # # April 3, 2018
        # survey_dw_april_3_service_allie = SurveyService.new({user_id: @llie.id,team_id: @w_swim.id,survey_type: 'Daily Wellness',datetime_today: Time.new(2018,4,19,23,59,59,'-04:00'),hours_of_sleep: 3,quality_of_sleep: 1,academic_stress: 2,life_stress: 1,soreness: 4,ounces_of_water_consumed: 50,hydration_quality: true})
        # @survey_dw_april_3_allie = survey_dw_april_3_service_allie.get_survey_object
        
        # # April 4, 2018
        # survey_dw_april_4_service_allie = SurveyService.new({user_id: @llie.id,team_id: @w_swim.id,survey_type: 'Daily Wellness',datetime_today: Time.new(2018,4,20,23,59,59,'-04:00'),hours_of_sleep: 4,quality_of_sleep: 5,academic_stress: 3,life_stress: 3,soreness: 2,ounces_of_water_consumed: 24,hydration_quality: true})
        # @survey_dw_april_4_allie = survey_dw_april_4_service_allie.get_survey_object
        
        
        # # April 5, 2018
        # survey_dw_april_5_service_allie = SurveyService.new({user_id: @llie.id,team_id: @w_swim.id,survey_type: 'Daily Wellness',datetime_today: Time.new(2018,4,21,23,59,59,'-04:00'),hours_of_sleep: 3,quality_of_sleep: 1,academic_stress: 3,life_stress: 3,soreness: 2,ounces_of_water_consumed: 15,hydration_quality: false})
        # @survey_dw_april_5_allie = survey_dw_april_5_service_allie.get_survey_object
        
        # # April 6, 2018
        # survey_dw_april_6_service_allie = SurveyService.new({user_id: @llie.id,team_id: @w_swim.id,survey_type: 'Daily Wellness',datetime_today: Time.new(2018,4,22,23,59,59,'-04:00'),hours_of_sleep: 4,quality_of_sleep: 2,academic_stress: 2,life_stress: 1,soreness: 3,ounces_of_water_consumed: 60,hydration_quality: true})
        # @survey_dw_april_6_allie = survey_dw_april_6_service_allie.get_survey_object
        
        # survey_dw_april_6_service_allie2 = SurveyService.new({user_id: @llie.id,team_id: @w_swim.id,survey_type: 'Daily Wellness',datetime_today: Time.new(2018,4,23,23,59,59,'-04:00'),hours_of_sleep: 4,quality_of_sleep: 2,academic_stress: 2,life_stress: 1,soreness: 3,ounces_of_water_consumed: 60,hydration_quality: true})
        # @survey_dw_april_6_allie2 = survey_dw_april_6_service_allie2.get_survey_object
  
  
  
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
  