require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "point_tracker_project"

  end

  get "/" do
    if logged_in?

      redirect "/users/#{current_user.slug}"
    else
      erb :index
    end
  end

  get "/access-error" do
    erb :"/access-error"
  end

  helpers do 
    def logged_in? #checks if a user is logged in
      !!session[:user_id]
    end

    def current_user #finds User object matching session user_id
      User.find(session[:user_id])
    end

    def logged_out_redirection #checks if a user is not logged in and redirects to login page
      if !logged_in?
        redirect "/login"
      end
    end

    def sort_horseshows_from_current_user #sorts horseshows by date from users list of horseshows
      current_user.horseshows.order(:date).uniq
    end
  end
end
