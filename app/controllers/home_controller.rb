class HomeController < ApplicationController
  before_filter :authenticate_user!, only:[:search,:search_result]

  def index
    redirect_to search_path if user_signed_in?
  end

  def contact
  end

  def search
    @user = User.select([:id,:first_name, :last_name, :email,:status])
  end

  def search_result
    query = params[:users][:first_name]
    @user = User.where("first_name = ?",query).first
  end
end
