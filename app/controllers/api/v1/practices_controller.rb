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
            param :form, :duration, :integer, :required, "Duration"
            param :form, :difficulty, :integer, :required, "Difficulty"
            param :form, :practice_time, :datetime, :required, "Date"
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
            weeks_repeated = practice_params[:num_weeks]
            recurring_weekly = practice_params[:recurring_weekly]

            # default the practice duration to be 2 hours, difficulty 5
            if practice_params[:practice_time].nil?
              practice_params[:practice_time] = 120
            end
            if practice_params[:difficulty].nil?
              practice_params[:difficulty] = 5
            end


            if (weeks_repeated && (weeks_repeated.is_a? Integer))
              if weeks_repeated < 1
                render json: { errors: "invalid number of repeated weeks" }, status: :unprocessable_entity
                return
              end
              week_offset = 86400

              repeat_count = 0
              all_practices = []
              loop do
                practice_datetime = practice_params[:practice_time]
                if practice_datetime.nil?
                  render json: { errors: "invalid number of repeated weeks" }, status: :unprocessable_entity
                end

                practice_time_mult = practice_params[:practice_time] + ( repeat_count * week_offset )

                current_practice = Practice.new(team_id: practice_params[:team_id], duration: practice_params[:duration], difficulty: practice_params[:difficulty], practice_time: practice_time_mult)
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
              render json: all_practices, status: :created, location: [:v1, all_practices]

            else
              @practice = Practice.new(practice_params)
              if @practice.save
                  render json: @practice, status: :created, location: [:v1, @practice]
              else
                  render json: @practice.errors, status: :unprocessable_entity
              end
            end
        end

        # PATCH/PUT /practices/1
        def update
            if @practice.update(practice_params)
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
