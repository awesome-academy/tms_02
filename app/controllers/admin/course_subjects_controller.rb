class Admin::CourseSubjectsController < ApplicationController
  before_action :load_course_subject, :correct_user
  before_action :load_object, only: %i(show edit)

  def show
    @user_course = current_user.user_courses.find_by_course_id @course.id
  end

  def edit
    @course_subject = @course.course_subjects.find_by_subject_id @subject.id
  end

  private

  def load_course_subject
    @course_subject = CourseSubject.find_by course_id: params[:course_id],
      subject_id: params[:subject_id]
    return if @course_subject
    flash[:danger] = t "not_found"
    redirect_to admin_root_path
  end

  def load_object
    @course = Course.find_by id: params[:id]
    @subject = Subject.find_by id: params[:id]
    return if @course && @subject
    flash[:danger] = t "not_found"
    redirect_to admin_courses_path
  end

  def correct_user
    supervisor_course = current_user.supervisor_courses.find_by id: params[:id][:course_id]
    unless supervisor_course.present?
      flash[:error] = t "not_permit"
      redirect_to admin_courses_path
    end
  end
end
