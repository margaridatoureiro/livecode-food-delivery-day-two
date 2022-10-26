require_relative "../views/meal_view"

class MealsController
  def initialize(meal_repository)
    @meal_repository = meal_repository
    @view = MealView.new
  end

  def add 
    # Ask the user for a meal name
    name = @view.ask_user_for(:name)
    # Ask the user for a meal price
    price = @view.ask_user_for(:price).to_i
    # Create an instance of Meal
    meal = Meal.new(name: name, price: price)
    # Give the meal to the meal repository
    @meal_repository.create(meal)
  end

  def list 
    # Grab all the meals from the meal repository
    meals = @meal_repository.all
    # Give them to the view to display them
    @view.display(meals)
  end
end