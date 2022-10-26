require_relative "../views/session_view"

class SessionsController
  def initialize(employee_repository)
    @view = SessionView.new
    @employee_repository = employee_repository
  end 

  def sign_in
    # Ask the user for a username
    username = @view.ask_user_for(:username)
    # Ask the user for the password
    password = @view.ask_user_for(:password)
    # Check if username exists in the employee repository
    employee = @employee_repository.find_by_username(username)
    # Check if the username and password match
    if employee && employee.password == password
      @view.successfully_signed_in(employee)
      return employee
    else
      @view.wrong_credentials
      sign_in # Recursive call
    end
  end
end