class CoursesController < ApplicationController
  before_filter :signed_in_teacher, only: [:index, :new, :edit, :update, :destroy, ]
  before_filter :admin_teacher, only: [:destroy, :new, :edit, :update]

  def index
    @courses = Course.paginate(page: params[:page], order: 'updated_at DESC')
  end

  def show
    @course = Course.find(params[:id])
  end

  def new
    @course = Course.new
  end

  def create
    @course = Course.new(params[:course])
    @course.day_of_week = @course.start_date.wday
    if @course.save
      flash[:success] = "#{@course.title} was added"
      redirect_to @course
    else
      render 'new'
    end
  end

  def edit
    @course = Course.find(params[:id])
  end

  def update
    @course = Course.find(params[:id])
    if @course.update_attributes(params[:course])
      flash[:success] = "Course updated"
      redirect_to @course
    else
      render 'edit'
    end
  end

  def destroy
    Course.find(params[:id]).destroy
    flash[:success] = "Course destroyed."
    redirect_to courses_path
  end

  private

  def signed_in_teacher
    unless teacher_signed_in?
      store_location
      redirect_to teachers_signin_path, notice: "Please sign in."
    end
  end

  def admin_teacher
    if !current_teacher.admin?
      redirect_to teachers_path
    end
  end
end
