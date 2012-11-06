class HomeController < ApplicationController
  include HomeHelper

  before_filter :authenticate_user!

  def index
    @user = current_user
    flash.delete :notice
  end

  def show_area
    @params = params
    #binding.pry
    @user = current_user

    @name_profiles = get_theatres params
    @params[:name_profiles] = @name_profiles
  end

  def add_neighbor
    render :text => 'FROM add_neighbor'
  end
end
