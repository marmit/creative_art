class TeachersController < ApplicationController
  before_filter :signed_in_teacher
  before_filter :correct_teacher, only: [:edit, :update]
  before_filter :admin_teacher, only: [:destroy, :new, :edit]

  def index
    @teachers = Teacher.paginate(page: params[:page], order: 'teacher_name')
  end

  def show
    @teacher = Teacher.find(params[:id])
  end

  def new
    @teacher = Teacher.new
  end

  def create
    @teacher = Teacher.new(params[:teacher])
    if @teacher.save
      teacher_sign_in @teacher
      flash[:success] = "Welcoming The New Teacher"
      redirect_to @teacher
    else
      render 'new'
    end
  end

  def edit
    @teacher = Teacher.find(params[:id])
  end

  def update
    if params[:password].blank?
      params.delete(:password)
      params.delete(:password_confirmation) if params[:password_confirmation].blank?
    end
    @teacher = Teacher.find(params[:id])
    if @teacher.update_attributes(params[:teacher])
      flash[:success] = "Profile updated"
      if !current_teacher.admin?
        teacher_sign_in @teacher
      end
      redirect_to @teacher
    else
      render 'edit'
    end
  end

  def destroy
    Teacher.find(params[:id]).destroy
    flash[:success] = "Teacher destroyed."
    redirect_to teachers_path
  end

  private

    def signed_in_teacher
      unless teacher_signed_in?
        store_location
        redirect_to teachers_signin_path, notice: "Please sign in."
      end
    end

    def correct_teacher
      @teacher = Teacher.find(params[:id])
      redirect_to(root_path) unless current_teacher?(@teacher) || current_teacher.admin?
    end

    def admin_teacher
      if !current_teacher.admin?
        redirect_to teachers_path
      end
    end
end
