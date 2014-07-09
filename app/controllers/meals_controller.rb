class MealsController < ApplicationController

  def index
    if user_signed_in?
      @my_meals = current_user.hosted_meals.order(hosted_at: :asc)
      @friends_meals = current_user.guest_meals(hosted_at: :asc)
      @invites = current_user.invited_meals(hosted_at: :asc)
      @declined = current_user.declined_meals(hosted_at: :asc)
    end
  end

  def new
    @meal = Meal.new
  end

  def create
    @meal = Meal.new(meal_params)
    current_user.user_meals.new(meal: @meal, role: 'host', invite_status: 'attending')

    if current_user.save
      redirect_to root_path, notice: "Your meal was created"
    else
      #
    end
  end

  def show
    if user_signed_in?
      @meal = Meal.find(params[:id])
      @guests = @meal.attending_guests
      @usermeal = @meal.guest_user_meals.where(user_id: current_user).first
      redirect_to root_path unless @usermeal.present?
    else
      redirect_to root_path
    end
  end

  def destroy
    @meal = Meal.find(params[:id])
    @meal.destroy
    redirect_to root_path, notice: "Meal deleted"
  end

  private

  def meal_params
    params.require(:meal).permit(:title, :location, :hosted_at)
  end

end
