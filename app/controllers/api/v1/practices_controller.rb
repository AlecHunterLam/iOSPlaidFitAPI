module Api::V1
    class PracticesController < ApplicationController

        swagger_controller :practices, "Practices Management"

        swagger_api :index do
            summary "Fetches all Practices"
            notes "This lists all the Practices"
        end

        swagger_api :show do
            summary "Shows one Practice"
            param :path, :id, :integer, :required, "Practice ID"
            notes "This lists details of one practice"
            response :not_found
        end

        swagger_api :create do
            summary "Creates a new Practice"
            param :form, :team_id, :integer, :required, "Team ID"
            param :form, :duration, :integer, :optional, "Duration"
            param :form, :difficulty, :integer, :optional, "Difficulty"
            param :form, :practice_time, :datetime, :required, "Date"
            param :form, :recurring_weekly, :boolean, :optional, "whether you want to repeat this over more than one weeks"
            param :form, :num_weeks, :int, :optional, "weeks to repeat for"
            response :not_acceptable
        end

        swagger_api :update do
            summary "Updates an existing Practice"
            param :path, :id, :integer, :required, "Practice ID"
            param :path, :team_id, :integer, :required, "Team ID"
            param :form, :duration, :integer, :optional, "Duration"
            param :form, :difficulty, :integer, :optional, "Difficulty"
            param :form, :practice_time, :datetime, :optional, "Date"
            response :not_found
            response :not_acceptable
        end

        swagger_api :destroy do
            summary "Deletes an existing Practice"
            param :path, :id, :integer, :required, "Practice ID"
            response :not_found
        end

        before_action :set_practice, only: [:show, :update, :destroy]

        # GET /practices
        def index
            @practices = Practice.all
            render json: @practices
        end

        # GET /practices/1
        def show
            render json: @practice
        end

        # POST /practices
        def create
            weeks_repeated = practice_params[:num_weeks].to_i
            recurring_weekly = practice_params[:recurring_weekly]
            practice_duration = practice_params[:duration].to_i
            practice_difficulty = practice_params[:difficulty].to_i
            # default the practice duration to be 2 hours, difficulty 5

            # to_i returns 0 for strings like ""
            if practice_params[:duration] != "0" || practice_duration == 0
              practice_duration = 120
            end
            # check raw, check conversion
            if practice_params[:difficulty] == "0" && practice_difficulty == 0
              practice_difficulty = 0
            elsif practice_params[:difficulty] != "0" && practice_difficulty == 0
              practice_difficulty = 5
            end

            puts '1-' + (recurring_weekly).to_s
            puts '2-' + (recurring_weekly && (weeks_repeated.is_a? Integer)).to_s
            puts '3-' + ((weeks_repeated.is_a? Integer)).to_s

            if (recurring_weekly && (weeks_repeated.is_a? Integer))
              if weeks_repeated < 1
                render json: { errors: "invalid number of repeated weeks" }, status: :unprocessable_entity
                return
              end

              repeat_count = 0
              all_practices = []
              loop do
                practice_datetime = practice_params[:practice_time] + ' ' + Time.now.strftime( "%z" )
                if practice_datetime.nil?
                  render json: { errors: "invalid number of repeated weeks" }, status: :unprocessable_entity
                end

                puts practice_datetime
                practice_time_mult = DateTime.strptime(practice_datetime, "%d/%m/%Y, %H:%M:%S %z") + (7 * repeat_count)# add 7 for 7 days in a week
                puts practice_time_mult

                current_practice = Practice.new(team_id: practice_params[:team_id], duration: practice_duration, difficulty: practice_difficulty, practice_time: practice_time_mult)
                if current_practice.valid?
                  all_practices << current_practice
                else
                  render json: (current_practice.save).errors, status: :unprocessable_entity
                end

                repeat_count += 1
                # control structure
                if repeat_count == weeks_repeated
                  break
                end
              end
              # delay saving all of them, so we dont add some and not all
              all_practices.each{|p| p.save!}
              all_practices = {practices: all_practices}
              render json: all_practices, status: :created

            else
              @practice = Practice.new(team_id: practice_params[:team_id], duration: practice_duration, difficulty: practice_difficulty, practice_time: practice_params[:practice_time])
              if @practice.save
                  render json: @practice, status: :created, location: [:v1, @practice]
              else
                  render json: @practice.errors, status: :unprocessable_entity
              end
            end
        end

        # PATCH/PUT /practices/1
        def update
            if @practice.update(team_id: practice_params[:team_id], duration: practice_duration, difficulty: practice_difficulty,  practice_time: practice_params[:practice_time])
                render json: @practice
            else
                render json: @practice.errors, status: :unprocessable_entity
            end
        end

        # DELETE /practices/1
        def destroy
            @practice.destroy
        end

        private

        # Use callbacks to share common setup or constraints between actions.
        def set_practice
            @practice = Practice.find(params[:id])
        end

        # Only allow a trusted parameter "white list" through.
        def practice_params
            params.permit(:team_id, :duration, :difficulty, :practice_time, :recurring_weekly, :num_weeks);
        end

    end
end
