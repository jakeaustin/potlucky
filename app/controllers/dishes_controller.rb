class DishesController < ApplicationController

  def new
    @meal = Meal.find(params[:meal_id])
    @dish = Dish.new
  end

  def create
    @meal = Meal.find(params[:meal_id])
    @dish = Dish.new(dish_params)
    @dish.claimer_id = @meal.host_user_meals.id
    @dish.meal_id = @meal.id

    if @dish.save
      redirect_to meal_path(@meal), notice: "dish added to meal"
    else
      render :new
    end
  end

  def index
    @dishes = Dish.all
  end

  def show
    @dish = Dish.find(params[:id])
    @meal = Meal.find(params[:meal_id])
    @host = @meal.host_user_meals
    @claimer = UserMeal.find(@dish.claimer_id)
  end

  def update
  end

  def destroy
  end


  private

  def dish_params
    params.require(:dish).permit(:name, :thumb_url, :recipe_url, :claimer_id, :meal_id, :can_be_claimed)
  end

end
