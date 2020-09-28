require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "point_tracker" #change name???

  end

  get "/" do
    erb :welcome
  end

end
