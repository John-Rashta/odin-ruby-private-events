class UsersController < ApplicationController
  def show
    @events = User.find(params[:id]).events
  end
end
