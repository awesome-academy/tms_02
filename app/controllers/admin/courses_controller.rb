class Admin::CoursesController < ApplicationController
  before_action :load_courses, only: %i(show edit)

  def index
    @courses = Course.newest.page(params[:page]).per Settings.course.index_page
  end

  def new
    @course = Course.new
  end

  def edit; end

  def create
    @course = Course.new course_params
    if @course.save
      flash[:success] = t ".save_course"
      redirect_to admin_courses_path
    else
      flash[:danger] = t ".cannot_save"
      render :new
    end
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

  private

  def course_params
    params.require(:course).permit :name, :description, :start_at
  end

  def load_courses
    @course = Course.find_by id: params[:id]
    return @course
    flash[:danger] = t "not_found"
    redirect_to admin_root_path
  end
end
