class Admin::UserCoursesController < ApplicationController
  before_action :load_courses, :load_user_courses, only: :update

  def update
    @user_course.status = params[:finished]
    if @user_course.update_attributes finished: params[:finished]
      flash[:success] = t ("accept", user_course: user_course.user.name)
    else
      flash[:danger] = t ".can't_update"
    end
    redirect_to admin_course_path @course
  end

  private

  def load_user_courses
    @user_course = @course.user_courses.find_by id: params[:id]
    return if @user_course
    flash[:danger] = t "not_found"
    redirect_to admin_courses_path
  end

  def load_courses
    @course = Course.find_by id: params[:id]
    return if @course
    flash[:danger] = t "not_found"
    redirect_to admin_courses_path
  end
end
