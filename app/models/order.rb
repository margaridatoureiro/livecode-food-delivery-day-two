class Order 
  attr_accessor :id
  attr_reader :meal, :customer, :employee, :delivered
  def initialize(attributes = {})
    @id = attributes[:id]
    @delivered = attributes[:delivered] || false
    @meal = attributes[:meal] # instance of Meal
    @customer = attributes[:customer] # instance of Customer
    @employee = attributes[:employee] # instance of Employee
    #binding.pry
  end

  def delivered?
    @delivered
  end

  def deliver!
    @delivered = true
  end
end