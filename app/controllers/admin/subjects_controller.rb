class Admin::SubjectsController < ApplicationController
  before_action :load_subject, except: %i(new create index)
  after_action :build_tasks, only: :show

  def index
    @subjects = Subject.sort_by_name.page(params[:page]).per Settings.subject.page
  end

  def show; end

  def edit;  end

  def new
    @subject = Subject.new
    @task = @subject.tasks.build
  end

  def create
    @subject = Subject.new subject_params
    if @subject.save
      flash[:success] = t ".subject_created"
      redirect_to admin_subjects_path
    else
      render :new
    end
  end

  def update
    if @subject.update_attributes subject_params
      flash[:success] = t ".update_subject"
      redirect_to admin_subject_path @subject
    else
      render :edit
    end
  end

  def destroy
    if @subject.destroy
      flash[:success] = t ".subject_deleted"
    else
      flash[:danger] = t "error"
    end
    redirect_to admin_subject_path @subject
  end

  private

  def subject_params
    params.require(:subject).permit :name, :description,
      tasks_attributes: [:id, :name, :description]
  end

  def load_subject
    @subject = Subject.find_by id: params[:id]
    return if @subject
    flash[:danger] = t "not_found"
    redirect_to root_path
  end

  def build_tasks
    @tasks = @subject.tasks
    @task = Task.new
  end
end
