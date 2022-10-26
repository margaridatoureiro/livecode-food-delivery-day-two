require_relative "app/controllers/customers_controller"
require_relative "app/controllers/meals_controller"
require_relative "app/controllers/sessions_controller"
require_relative "app/controllers/orders_controller"

require_relative "app/repositories/customer_repository"
require_relative "app/repositories/meal_repository"
require_relative "app/repositories/employee_repository"
require_relative "app/repositories/order_repository"

require_relative "router"

MEALS_CSV_PATH = "data/meals.csv"
CUSTOMERS_CSV_PATH = "data/customers.csv"
EMPLOYEES_CSV_PATH = "data/employees.csv"
ORDERS_CSV_PATH = "data/orders.csv"

customer_repository = CustomerRepository.new(CUSTOMERS_CSV_PATH)
meal_repository = MealRepository.new(MEALS_CSV_PATH)
employee_repository = EmployeeRepository.new(EMPLOYEES_CSV_PATH)
order_repository = OrderRepository.new(ORDERS_CSV_PATH, meal_repository, customer_repository, employee_repository)

customers_controller = CustomersController.new(customer_repository)
meals_controller = MealsController.new(meal_repository)
sessions_controller = SessionsController.new(employee_repository)
orders_controller = OrdersController.new(meal_repository, customer_repository, employee_repository, order_repository)

router = Router.new(meals_controller, customers_controller, sessions_controller, orders_controller)

router.run
