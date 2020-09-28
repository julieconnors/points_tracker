class UsersController < ApplicationController

    get '/login' do
        erb :"/users/login"
    end

    get '/account' do #should I have this or erb in post 'login' ???
        erb :'/users/home'
    end

    post '/login' do
        @user = User.all.find_by(username: params[:username])

        if @user
            session[:user_id] = @user.id

            erb :"/users/home"
            #redirect to "/account"
        else
            erb :error
        end
    end
    
    get '/signup' do
        erb :"/users/signup"
    end

    post '/signup' do
        @user = User.create(params)
        session[:user_id] = @user.id

        redirect to "/users/home"
    end

    get '/logout' do
        session.clear

        redirect to '/'
    end
end