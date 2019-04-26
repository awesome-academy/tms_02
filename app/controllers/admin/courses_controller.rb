class Admin::CoursesController < ApplicationController
  before_action :load_courses, except: %i(new index create)
  after_action :load_subjects, only: :new

  def index
    @courses = Course.newest.page(params[:page]).per Settings.course.index_page
  end

  def new
    @course = Course.new
    @course_subject = @course.course_subjects.build
  end

  def show
    @course_subjects = @course.course_subjects
  end

  def edit; end

  def create
    @course = Course.new course_params
    ActiveRecord::Base.transaction do
      @course.save
      flash[:success] = t ".create"
      redirect_to admin_courses_path @course
    end
  rescue Exception
    flash[:danger] = t ".error"
    redirect_to admin_courses_path @course
  end

  def update
    if @course.update_attributes course_params
      flash[:success] = t ".course_update"
      redirect_to admin_courses_path
    else
      flash[:danger] = t ".cannot_update"
      render :edit
    end
  end

  def destroy
    if @course.destroy
      flash[:success] = t "destroy"
      redirect_to admin_course_path @course
    else
      flash[:danger] = t ".can't_destroy"
      redirect_to admin_root_path
    end
  end

  private

  def course_params
    params.require(:course).permit :name, :description, :start_at,
      course_subjects_attributes: [:id, :course_id, :subject_id, :_destroy]
  end

  def load_courses
    @course = Course.find_by id: params[:id]
    return if @course
    flash[:danger] = t "not_found"
    redirect_to admin_root_path
  end

  def load_subjects
    @subject = Subject.sort_by_name
  end

  def enrolled_course
    @course = Course.find_by id: params[:id]
    unless @course.supervisor_courses.find_by user_id: current_user.id
      flash[:error] = t "can't_edit"
      redirect_to admin_courses_path
    end
  end
end
