module SessionsHelper

  def teacher_sign_in(teacher)
    cookies.permanent[:remember_token] = teacher.remember_token
    self.current_teacher = teacher
  end

  def teacher_signed_in?
    !current_teacher.nil?
  end

  def current_teacher=(teacher)
    @current_teacher = teacher
  end

  def current_teacher
    @current_teacher ||= Teacher.find_by_remember_token(cookies[:remember_token])
  end

  def teacher_sign_out
    self.current_teacher = nil
    cookies.delete(:remember_token)
  end
end
