require 'csv'
require_relative "../models/order"
require "pry-byebug"

class OrderRepository 
  def initialize(orders_csv_path, meal_repository, customer_repository, employee_repository)
    @orders_csv_path = orders_csv_path
    @meal_repository = meal_repository
    @customer_repository = customer_repository
    @employee_repository = employee_repository
    @orders = []
    @next_id = 1
    load_csv if File.exist?(orders_csv_path)
  end

  def create(order) 
    order.id = @next_id
    @orders << order 
    @next_id += 1
    save_csv
  end

  def mark_as_delivered(order)
    order.deliver!
    save_csv
  end

  def undelivered_orders
    #@orders.reject { |order| order.delivered? }
    @orders.select { |order| !order.delivered? }
  end

  def my_undelivered_orders(employee)
    @orders.select do |order| 
      order.employee == employee && !order.delivered?
    end
  end

  
  private
  
  def save_csv
    CSV.open(@orders_csv_path, 'wb') do |csv|
      csv << ["id", "delivered", "meal_id", "customer_id", "employee_id"]
      @orders.each do |order|
        #binding.pry
        csv << [order.id, order.delivered?, order.meal.id, order.customer.id, order.employee.id]
      end
    end
  end
  
  def load_csv
    CSV.foreach(@orders_csv_path, headers: :first_row, header_converters: :symbol) do |row|
      row[:id] = row[:id].to_i
      row[:delivered] = row[:delivered] == "true"
      row[:meal] = @meal_repository.find(row[:meal_id].to_i) # instance of Meal
      row[:customer] = @customer_repository.find(row[:customer_id].to_i) # instance of Meal
      row[:employee] = @employee_repository.find(row[:employee_id].to_i) # instance of Meal
      #binding.pry
      @orders << Order.new(row) # call the initialize method of Order
    end
    @next_id = @orders.empty? ? 1 : @orders.last.id + 1
  end

end