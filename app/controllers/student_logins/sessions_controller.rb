module StudentLogins
  class SessionsController < Devise::SessionsController
    def check_login
      if student_login_signed_in?
        # Check if the logged-in user is an admin or student
        if current_student_login.is_admin?
          redirect_to admin_dashboard_path # Redirect to admin dashboard
        else
          redirect_to student_dashboard_path(current_student_login.id) # Redirect to student dashboard
        end
      else
        redirect_to new_student_login_session_path # Redirect to login page
      end
    end

    # After sign-in redirect logic (if using regular Devise)
    def after_sign_in_path_for(resource_or_scope)
      if current_student_login.is_admin?
        admin_dashboard_path # Admin dashboard path
      else
        student_dashboard_path(current_student_login.id) # Student dashboard path
      end
    end

    # After sign-out redirect
    def after_sign_out_path_for(_resource_or_scope)
      new_student_login_session_path
    end
  end
end
