class MealsController < ApplicationController

  def index
    if user_signed_in?
      @my_meals = current_user.hosted_meals.order(hosted_at: :asc)
      @friends_meals = current_user.guest_meals(hosted_at: :asc)
      @invites = current_user.invited_meals(hosted_at: :asc)
    end
  end

  def new
    @meal = Meal.new
  end

  def create
    # current_user.meals.new(meal_params)
    @meal = Meal.new(meal_params)
    current_user.user_meals.new(meal: @meal, role: 'host', invite_status: 'attending')

    if current_user.save
      redirect_to root_path, notice: "Your meal was created"
    else
      #
    end
  end

  def show
    @meal = Meal.find(params[:id])
  end


  private

  def meal_params
    params.require(:meal).permit(:title, :location, :hosted_at)
  end

end
