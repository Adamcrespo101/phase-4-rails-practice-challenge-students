class InstructorsController < ApplicationController
rescue_from ActiveRecord::RecordInvalid, with: :invalid
    before_action :find_instructor
    def index 
        render json: Instructor.all
    end
    
    def show 
        if @instructor 
            render json: @instructor 
        else
            render json: {error: "instructor missing try again"}, status: :not_found
        end
    end

    def update 
        if @instructor 
         @instructor.update(instructor_params)
         render json: @instructor
        else
            render json: {error: "instructor missing try again"}, status: :not_found
        end
    end

    def create 
        instructor = Instructor.create(instructor_params)
        render json: instructor, status: :accepted
    end

    def destroy 
        if @instructor 
            @instructor.destroy 
        else
            render json: {error: "instructor missing try again"}, status: :not_found
        end
    end

    private 

    def instructor_params
        params.permit(:name)
    end

    def find_instructor 
        @instructor = Instructor.find_by(id: params[:id])
    end

    def invalid invalid
        render json: {error: invalid.record.errors.full_messages}
    end
end
