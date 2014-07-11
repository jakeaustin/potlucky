class MealsController < ApplicationController

  def index
    if user_signed_in?
      @my_meals = current_user.hosted_meals.order(hosted_at: :desc)
      @friends_meals = current_user.guest_meals.order(hosted_at: :desc)
      @invites = current_user.invited_meals.order(hosted_at: :desc)
      @declined = current_user.declined_meals.order(hosted_at: :desc)
    end
  end

  def new
    @meal = Meal.new
  end

  def create
    @meal = Meal.new(meal_params)
    current_user.invites.new(meal: @meal, role: 'host', invite_status: 'attending')

    if current_user.save
      redirect_to root_path, notice: "Your meal was created"
    else
      redirect_to :new, notice: "there was an error saving your meal"
    end
  end

  def show
    if user_signed_in?
      @meal = Meal.find(params[:id])
      @guests = @meal.attending_guests
      @dishes = @meal.dishes
      @invite = @meal.guest_invites.find_by(user_id: current_user)
      @comments = @meal.comments
      redirect_to root_path unless @invite.present?
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
