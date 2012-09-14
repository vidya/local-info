class HomeController < ApplicationController
  def index
    #@users = User.all
    redirect_to :controller => :zip_code
  end
end
