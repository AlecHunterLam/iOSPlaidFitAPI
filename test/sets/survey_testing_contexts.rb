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
            (1..10).each do |i|
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
            # create practices for past two weeks
            (0..10).each do |i|  
                duration = Faker::Number.between(0, 180)
                difficulty = Faker::Number.between(1, 10)
                practice_time = Time.new(2018, 5, 11 - i, Faker::Number.between(10, 18), [0, 30].sample, 0, '-04:00')
                practice = Practice.create(team: team, duration: duration, difficulty: difficulty, practice_time: practice_time)
                practices.push(practice)
            end
            (0..29).each do |i|  
                duration = Faker::Number.between(0, 180)
                difficulty = Faker::Number.between(1, 10)
                practice_time = Time.new(2018, 4, 30 - i, Faker::Number.between(10, 18), [0, 30].sample, 0, '-04:00')
                practice = Practice.create(team: team, duration: duration, difficulty: difficulty, practice_time: practice_time)
                practices.push(practice)
            end
        end
        return practices
      end 

      def create_daily_wellness_surveys(users)
        users.each do |user|
            (0..10).each do |i|
                survey_service = SurveyService.new({user_id: user.id, team_id: user.team_assignments.first.team_id, survey_type: 'Daily Wellness', datetime_today: Time.new(2018, 5, 11 - i, 23, 59, 59, '-04:00'),
                                                    hours_of_sleep: Faker::Number.between(0, 12), quality_of_sleep: Faker::Number.between(1, 10), academic_stress: Faker::Number.between(1, 5), 
                                                    life_stress: Faker::Number.between(1, 5), soreness: Faker::Number.between(1, 10),ounces_of_water_consumed: Faker::Number.between(1, 128), hydration_quality: [true, false].sample})
                survey_service.get_survey_object
            end
            (0..29).each do |i|
                survey_service = SurveyService.new({user_id: user.id, team_id: user.team_assignments.first.team_id, survey_type: 'Daily Wellness', datetime_today: Time.new(2018, 4, 30 - i, 23, 59, 59, '-04:00'),
                                                    hours_of_sleep: Faker::Number.between(0, 12), quality_of_sleep: Faker::Number.between(1, 10), academic_stress: Faker::Number.between(1, 5), 
                                                    life_stress: Faker::Number.between(1, 5), soreness: Faker::Number.between(1, 10),ounces_of_water_consumed: Faker::Number.between(1, 128), hydration_quality: [true, false].sample})
                survey_service.get_survey_object
            end
        end
      end
      
      def create_post_practice_surveys(users, practices)
        users.each do |user|
            (0..10).each do |i|
                player_rpe_rating = Faker::Number.between(0, 10)
                player_personal_performance = Faker::Number.between(1, 10)
                datetime_today = Time.new(2018, 5, 11 - i, 23, 59, 59, '-04:00')
                survey_service = SurveyService.new({user_id: user.id, team_id: user.team_assignments.first.team_id, practice_id: 1, survey_type: 'Post-Practice', datetime_today: datetime_today,
                                                   player_rpe_rating: player_rpe_rating, player_personal_performance: player_personal_performance, participated_in_full_practice: [true, false].sample,
                                                   minutes_participated: Faker::Number.between(0, 100)})
                survey_service.get_survey_object
            end
            (0..29).each do |i|
                player_rpe_rating = Faker::Number.between(0, 10)
                player_personal_performance = Faker::Number.between(1, 10)
                datetime_today = Time.new(2018, 4, 30 - i, 23, 59, 59, '-04:00')
                survey_service = SurveyService.new({user_id: user.id, team_id: user.team_assignments.first.team_id, practice_id: 1, survey_type: 'Post-Practice', datetime_today: datetime_today,
                                                   player_rpe_rating: player_rpe_rating, player_personal_performance: player_personal_performance, participated_in_full_practice: [true, false].sample,
                                                   minutes_participated: Faker::Number.between(0, 100)})
                survey_service.get_survey_object
            end
        end
      end

      def create_events
        (0..8).each do |i|
            Event.create(user_id: Faker::Number.between(4, 30), description: "test event number " + i.to_s, event_time: Time.new(2018, 5, 11 + i, 16, 30, 00, '-04:00'))
            # Event.create(user_id: 63, description: "qapla", event_time: Time.new(2018, 5, 2, 10, 10, 00, '-04:00'))
        end
      end 

      def create_notifications
        (0..5).each do |i|
            Notification.create(user_id: i + 10, receiver_id: 1, priority: "Low", message: "test notification " + i.to_s, notified_time: Time.new(2018, 5, 11 - i, 23, 59, 59, '-04:00'))
        end
    end

      def create_calculations(users, teams)
        users.each do |user|
            if (user.role == "Player") 
                a = get_player_calculation(user_id: user.id, week_of: Time.new(2018, 4, 30, 0, 0, 0, '-04:00'))
                a.save!
                set_relative_rank(a)
                a.save!
                b = get_player_calculation(user_id: user.id, week_of: Time.new(2018, 4, 23, 0, 0, 0, '-04:00'))
                b.save!
                set_relative_rank(b)
                b.save!
                c = get_player_calculation(user_id: user.id, week_of: Time.new(2018, 4, 16, 0, 0, 0, '-04:00'))
                c.save!
                set_relative_rank(c)
                c.save!
            end
        end
        teams.each do |team|
            a = get_team_calculation_object(team_id: team.id, week_of: Time.new(2018, 4, 30, 0, 0, 0, '-04:00'))
            #a = get_team_calculation_object(team_id: 3, week_of: Time.new(2018, 4, 30, 0, 0, 0, '-04:00'))
            a.save!
            set_relative_rank_t(a)
            a.save!
            b = get_team_calculation_object(team_id: team.id, week_of: Time.new(2018, 4, 23, 0, 0, 0, '-04:00'))
            b.save!
            set_relative_rank_t(b)
            b.save!
            c = get_team_calculation_object(team_id: team.id, week_of: Time.new(2018, 4, 16, 0, 0, 0, '-04:00'))
            c.save!
            set_relative_rank_t(c)
            c.save!
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
        create_calculations(users, teams)
      end

      def delete_stuff
        Survey.destroy_all
        TeamAssignment.destroy_all
        Practice.destroy_all
        User.destroy_all
        Team.destroy_all
        Event.destroy_all
        Notification.destroy_all
      end 

      def get_player_calculation(partial_calculation_object)
        @season = get_current_season
        @week_of = partial_calculation_object[:week_of]
        @user_id = partial_calculation_object[:user_id]

        @player_calculation = PlayerCalculation.new
        @player_calculation.week_of = @week_of
        @player_calculation.user_id = @user_id
        @player_calculation.season = @season
        # must start on a monday
        if (User.find(@user_id).nil?)
          return nil
        end

        # get start of week/end of week
        start_week = DateTime.new(@player_calculation.week_of.year, @player_calculation.week_of.month, @player_calculation.week_of.day, 0,0,0, @player_calculation.week_of.strftime( "%z" ));
        end_week = DateTime.new(@player_calculation.week_of.year, @player_calculation.week_of.month, @player_calculation.week_of.day, 23,59,59,  @player_calculation.week_of.strftime( "%z" )) + 6;

        all_player_post = Survey.for_user(@player_calculation.user_id).post_practice.surveys_for_week(start_week, end_week)
        all_player_wellness = Survey.for_user(@player_calculation.user_id).daily_wellness.surveys_for_week(start_week, end_week)

        # set daily wellness fields
        sleep_quality_list = []
        sleep_amount_list =[]
        hydration_quality_list = []
        hydration_amount_list = []
        academic_stress_list = []
        life_stress_list = []

        # wellness
        all_player_wellness.each do |s|
          sleep_quality_list << s.quality_of_sleep
          sleep_amount_list << s.hours_of_sleep
          hydration_quality_list << 1 ? s.hydration_quality : hydration_quality_list << 0
          hydration_amount_list << s.ounces_of_water_consumed
          academic_stress_list << s.academic_stress
          life_stress_list << s.life_stress
        end

        @player_calculation.sleep_quality_average = sleep_quality_list.mean
        @player_calculation.sleep_amount_average = sleep_amount_list.mean
        @player_calculation.hydration_quality_average = hydration_quality_list.mean
        @player_calculation.hydration_amount_average = hydration_amount_list.mean
        @player_calculation.academic_stress_average = academic_stress_list.mean
        @player_calculation.life_stress_average = life_stress_list.mean

        # post practice
        daily_load_list = []

        latest_survey = all_player_post.chronological.first
        if latest_survey.nil?
          return nil
        end

        # set params from latest post practice survey
        @player_calculation.weekly_load = latest_survey.weekly_load
        @player_calculation.weekly_strain = latest_survey.weekly_strain
        @player_calculation.week_to_week_weekly_load_percent_change = latest_survey.week_to_week_weekly_load_percent_change
        @player_calculation.monotony = latest_survey.monotony

        player_performance_list = []
        practice_difficulty_average_list = []
        all_player_post.each do |s|
          player_performance_list << s.player_personal_performance
          practice_difficulty_average_list << s.player_rpe_rating

        end

        @player_calculation.practice_difficulty_average = practice_difficulty_average_list.mean
        @player_calculation.personal_performance_average = player_performance_list.mean

        return @player_calculation
      end

      def get_current_season
        current_month = Time.now.month
        current_year = Time.now.year
        current_year = current_year.to_s
        # Fall Season
        if 8 <= current_month && current_month <= 12
          current_seasons = ("Fall-" + current_year)
        end
        if 11 <= current_month || current_month <= 3
          current_seasons = ("Winter-" + current_year)
        end
        if 2 <= current_month && current_month <= 6
          current_seasons = ("Spring-" + current_year)
        end
        if current_seasons == []
          current_seasons = ("Other-" + current_year)
        end
        return current_seasons
      end

      def set_relative_rank(pc)
        ranked_week_calculations_for_season = PlayerCalculation.for_user(pc.user_id).for_season(pc.season).rank_by_weekly_load
        i = ranked_week_calculations_for_season.length
        ranked_week_calculations_for_season.each do |calc|
          calc.update(season_rank: i)
          calc.save!
          i = i - 1
        end
        return
      end

      def set_relative_rank_t(tc)
        ranked_week_calculations_for_season = TeamCalculation.for_team(tc.team_id).rank_by_weekly_load #.for_season(@team_calculation.season)
        i = ranked_week_calculations_for_season.length
        ranked_week_calculations_for_season.each do |calc|
          puts calc
          calc.update(season_rank: i)
          calc.save!
          i = i - 1
        end
        return
      end

      def get_team_calculation_object(params)
        @team_id = params[:team_id]
        @week_of = params[:week_of]


        @team_calculation = TeamCalculation.new
        team = Team.find(@team_id)
        @team_calculation.season = team.season.to_s + "-" + (Time.now.year).to_s
        @team_calculation.week_of = params[:week_of]

        if (Team.find(@team_id).nil?)
          return nil
        end

        start_week = DateTime.new(@team_calculation.week_of.year, @team_calculation.week_of.month, @team_calculation.week_of.day, 0,0,0, @team_calculation.week_of.strftime( "%z" ));

        @team_calculation.week_of = start_week
        @team_calculation.team_id = @team_id

        all_player_calc = []
        all_players_for_team = User.all.by_team(@team_id).by_role("Player")
        all_players_for_team.each do |user|
          all_player_calc << PlayerCalculation.all.for_user(user.id).for_week(@team_calculation.week_of)
        end

        weekly_load_list = []
        weekly_strain_list = []
        life_stress_average_list = []
        academic_stress_average_list = []
        sleep_quality_average_list = []
        hydration_quality_average_list = []
        practice_difficulty_average_list = []
        team_monotony_list = []
        week_to_week_weekly_load_percent_change_list = []
        sleep_amount_average_list = []
        hydration_amount_average_list = []


        all_player_calc.each do |pc|
          if !(pc.blank?)
            pc = pc.first
            puts pc
            weekly_load_list << pc.weekly_load
            weekly_strain_list << pc.weekly_strain
            life_stress_average_list << pc.life_stress_average
            academic_stress_average_list << pc.academic_stress_average
            sleep_quality_average_list << pc.sleep_quality_average
            hydration_quality_average_list << pc.hydration_quality_average
            practice_difficulty_average_list << pc.practice_difficulty_average
            team_monotony_list << pc.monotony
            week_to_week_weekly_load_percent_change_list << pc.week_to_week_weekly_load_percent_change
            sleep_amount_average_list << pc.sleep_amount_average
            hydration_amount_average_list << pc.hydration_amount_average
          end
        end

        @team_calculation.weekly_load = weekly_load_list.mean
        @team_calculation.weekly_strain = weekly_strain_list.mean
        @team_calculation.life_stress_average = life_stress_average_list.mean
        @team_calculation.academic_stress_average = academic_stress_average_list.mean
        @team_calculation.sleep_quality_average = sleep_quality_average_list.mean
        @team_calculation.hydration_quality_average = hydration_quality_average_list.mean
        @team_calculation.practice_difficulty_average = practice_difficulty_average_list.mean
        @team_calculation.team_monotony = team_monotony_list.mean
        @team_calculation.week_to_week_weekly_load_percent_change = week_to_week_weekly_load_percent_change_list.mean
        @team_calculation.sleep_amount_average = sleep_amount_average_list.mean
        @team_calculation.hydration_amount_average = hydration_amount_average_list.mean

        return @team_calculation
      end

    end
  end

  
  
#   load './app/services/survey_service_v2.rb'
  
  # get_survey_object
  