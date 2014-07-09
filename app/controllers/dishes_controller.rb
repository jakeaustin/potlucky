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

  def show
    @dish = Dish.find(params[:id])
    @meal = Meal.find(params[:meal_id])
    @host = @meal.host_user_meals
    @claimer = UserMeal.find(@dish.claimer_id)
    @current_guest = current_user.user_meals.find_by(meal_id: @meal.id)
  end

  def update
    @dish = Dish.find(params[:id])
    @meal = Meal.find(params[:meal_id])
    @dish.can_be_claimed = params[:can_be_claimed]
    @dish.claimer_id = params[:claimer_id]

    if @dish.save
      redirect_to meal_path(@meal), notice: 'Responsibility for dish updated'
    else
      redirect_to meal_path(@meal), notice: 'Something went wrong during update'
    end
  end

  def destroy
    @meal = Meal.find(params[:meal_id])
    @dish = Dish.find(params[:id])
    @dish.destroy
    redirect_to meal_path(@meal), notice: "Dish deleted"
  end

  def search
    @meal = Meal.find(params[:meal_id])
    @results = Yummly.search(params[:search_term])
    @matches = @results.matches.map do |match|
      Yummly.find(match['id'])
    end
  end

  private

  def dish_params
    params.require(:dish).permit(:search_term, :name, :thumb_url, :recipe_url, :claimer_id, :meal_id, :can_be_claimed)
  end

end
