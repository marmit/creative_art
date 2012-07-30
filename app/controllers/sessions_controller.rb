class SessionsController < ApplicationController

  def new

  end

  def create
    teacher = Teacher.find_by_username(params[:session][:username])
    if teacher && teacher.authenticate(params[:session][:password])
      teacher_sign_in teacher
      redirect_to teacher
    else
      flash.now[:error] = 'Invalid username/password combination'
      render 'new'
    end
  end

  def destroy
    teacher_sign_out
    redirect_to root_path
  end
end
