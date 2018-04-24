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

    end
  end
  
#   Survey.destroy_all
#   TeamAssignment.destroy_all
#   Practice.destroy_all
#   User.destroy_all
#   Team.destroy_all
  
  
#   load './app/services/survey_service_v2.rb'
  
  # get_survey_object
  