class HomeController < ApplicationController
  before_filter :authenticate_user!

  def index
    flash[:notice] = 'Welcome to Local-Info'
    redirect_to :controller => :zip_code
  end
end
