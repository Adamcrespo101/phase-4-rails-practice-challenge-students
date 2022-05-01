class StudentsController < ApplicationController
    rescue_from ActiveRecord::RecordInvalid, with: :invalid
    before_action :find_student
    
    def index 
        render json: Student.all
    end
    
    def show 
        if @student 
            render json: @student 
        else
            render json: {error: "student missing try again"}, status: :not_found
        end
    end

    def update 
        if @student 
         @student.update(student_params)
         render json: @student
        else
            render json: {error: "student missing try again"}, status: :not_found
        end
    end

    def create 
        student = Student.create(student_params)
        render json: student, status: :accepted
    end

    def destroy 
        if @student 
            @student.destroy 
        else
            render json: {error: "student missing try again"}, status: :not_found
        end
    end

    private 

    def student_params
        params.permit(:name, :age, :major, :instructor_id)
    end

    def find_student 
        @student = Student.find_by(id: params[:id])
    end

    def invalid invalid
        render json: {error: invalid.record.errors.full_messages}
    end
end
