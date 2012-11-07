class HomeController < ApplicationController
  include HomeHelper

  before_filter :authenticate_user!

  def index
    @user = current_user
    flash.delete :notice
  end

  def show_area
    @params                   = params
    @params[:theatre_profiles]   = get_theatres params
  end

  def add_neighbor
    render :text => 'FROM add_neighbor'
  end
end
