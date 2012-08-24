def full_title(page_title)
  base_title = "Creative Art and Drawing Studio"
  if page_title.empty?
    base_title
  else
    "#{base_title} | #{page_title}"
  end

  def teacher_sign_in(teacher)
    visit teachers_signin_path
    fill_in "User Name", with: teacher.username
    fill_in "Password",  with: teacher.password
    click_button "Sign in"
    #Sign in when not using Cabybara as well.
    cookies[:remember_token] = teacher.remember_token
  end
end
