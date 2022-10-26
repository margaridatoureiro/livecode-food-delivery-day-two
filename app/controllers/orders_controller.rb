require_relative "../views/meal_view"
require_relative "../views/customer_view"
require_relative "../views/session_view"
require_relative "../views/order_view"
require_relative "../models/order"

class OrdersController
  def initialize(meal_repository, customer_repository, employee_repository, order_repository)
    @meal_repository = meal_repository
    @customer_repository = customer_repository
    @employee_repository = employee_repository
    @order_repository = order_repository
    @meal_view = MealView.new
    @customer_view = CustomerView.new
    @session_view = SessionView.new
    @order_view = OrderView.new
  end

  def add
    # Get all meals from the meal repo
    meals = @meal_repository.all
    # Display them to the user (indexed list)
    @meal_view.display(meals)
    # Ask the user which meal they want (which index)
    index = @meal_view.ask_user_for(:number).to_i - 1
    # Get the meal at given index
    meal = meals[index]

    # Get all customers from the customer repo
    customers = @customer_repository.all
    # Display them to the user (indexed list)
    @customer_view.display(customers)
    # Ask the user which customer they want (which index)
    index = @customer_view.ask_user_for(:number).to_i - 1
    # Get the customer at given index
    customer = customers[index]

     # Get all employees from the employee repo
     employees = @employee_repository.all_riders
     # Display them to the user (indexed list)
     @session_view.display(employees)
     # Ask the user which employee they want (which index)
     index = @session_view.ask_user_for(:number).to_i - 1
     # Get the customer at given index
     employee = employees[index]

     order = Order.new(meal: meal, customer: customer, employee: employee)

     @order_repository.create(order)
  end

  def list_my_orders(employee) # MY UNDELIVERED 
    # Get all my undelivered orders (I'm an employee!) from the repo
    my_undelivered = @order_repository.my_undelivered_orders(employee)
    # Display them
    @order_view.display(my_undelivered)
  end

  def list_undelivered_orders # EVERYONE'S UNDELIVERED (ALL!!!)
    # Get all undelivered orders from the repo
    all_undelivered = @order_repository.undelivered_orders
    # Display them
    @order_view.display(all_undelivered)
  end

  def mark_as_delivered(employee)
    # Display all my undelivered orders
    list_my_orders(employee)
    # Ask the user for an index of the order they want to mark as delivered
    index = @order_view.ask_user_for(:number).to_i - 1
    # Get all of my orders from the repo
    my_orders = @order_repository.my_undelivered_orders(employee)
    # Find the order at the given index
    order = my_orders[index]
    # Mark the order as delivered
    @order_repository.mark_as_delivered(order)
    # order.deliver!
    # @order_repository.save_csv
  end

end