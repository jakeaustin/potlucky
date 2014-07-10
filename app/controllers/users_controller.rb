class UsersController < ApplicationController

  def index
    if params[:search]
      @users = User.search(params[:search])
      @meal = Meal.find(params[:meal_id])
    else
      @meal = Meal.find(params[:meal_id])
      @users = User.all
    end
  end


end
