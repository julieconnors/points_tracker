require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "point_tracker_project"

  end

  get "/" do
    if !logged_in?
      erb :index
    else
      @user = current_user

      redirect "/users/#{@user.slug}"
    end
  end

  helpers do 
    def logged_in?
      !!session[:user_id]
    end

    def current_user
      User.find(session[:user_id])
    end

    def prize_valid?(params)
      return params[:horse_id] != nil && !params[:horseshow][:name].empty? && !params[:horseshow][:location].empty? && params[:point_total].to_i > 0
    end
  end
end
