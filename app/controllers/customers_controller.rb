require_relative "../views/customer_view"
require_relative "../models/customer"

class CustomersController
  def initialize(customer_repository)
    @customer_repository = customer_repository
    @view = CustomerView.new
  end

  def add 
    # Ask the user for a name
    name = @view.ask_user_for(:name)
    # Ask the user for an address
    address = @view.ask_user_for(:address)
    # Create an instance of Meal
    customer = Customer.new(name: name, address: address)
    # Give the meal to the meal repository
    @customer_repository.create(customer)
  end

  def list 
    # Grab all the meals from the meal repository
    customers = @customer_repository.all
    # Give them to the view to display them
    @view.display(customers)
  end
end